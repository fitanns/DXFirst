/**
 * @author Shokhanul Khok
 * @date 31/10/2018
 * @description Used for injection of implementations to interfaces
 * ---Usage---
 * Get Static Dependency:
 *  IMessanger messanger = (IMessanger)DependencyInjector.getInstance(IMessanger.class);
 * Get Dynamic Dependency:
 *  IMessanger messanger = (IMessanger)DependencyInjector.getInstance(IMessanger.class, 'Viber');
 *
 *  Dependencies are specified by Dependency_Binding__mdt records or can be added/overridden using  overrideByDynamic/overrideByStatic methods
 */

public class DependencyInjector {
    static final String DYNAMIC_BINDING = 'Conditional Instantiation',
            STATIC_BINDING = 'Class';

    private static Map<Type, Binding> bindingByTargetType;

    static {
        bindingByTargetType = new Map<Type, Binding>();
//        initDefaultBindings();
//        initBindings();
    }

    /**
    * @author Shokhanul Khok
    * @date 31/10/2018
    * @description Overrides default static implementation definiton
    * @param Type targetType interface which definition is going to be overriden
    * @param Type injectedType override type for target interface
    */
    public static void overrideByStatic(Type targetType, Type injectedType){
        overrideBy(targetType, injectedType, STATIC_BINDING);
    }

    /**
    * @author Shokhanul Khok
    * @date 31/10/2018
    * @description Overrides default dynamic implementation definiton
    * @param Type targetType interface which definition is going to be overridden
    * @param Type injectedType override type for target interface
    */
    public static void overrideByDynamic(Type targetType, Type injectedType){
        overrideBy(targetType, injectedType, DYNAMIC_BINDING);
    }

    private static void overrideBy(Type targetType, Type injectedType, String bindingType){
        bindingByTargetType.put(targetType, createBinding(targetType, injectedType, bindingType));
    }

    /**
    * @author Shokhanul Khok
    * @date 31/10/2018
    * @description retrieves a statically defined implementation for target interface
    * @param Type targetType interface which definition is going to injected
    * @exception DependencyInjectionException if injected type is not specified at all
    * @return implementation for target interface
    */
    public static Object getInstance(Type injectionTarget){
        return getInstance(injectionTarget, null);
    }

    /**
    * @author Shokhanul Khok
    * @date 31/10/2018
    * @description retrieves a dynamically defined implementation for target interface
    * @param Type targetType interface which definition is going to injected
    * @param param the value for condition to retrieve specific implementation
    * @exception DependencyInjectionException if injected type is neither an instance of a DependencyInjector.IFactory nor specified
    * @return implementation for target interface
    */
    public static Object getInstance(Type injectionTarget, Object param){
        if(injectionTarget == null){
            throw new DependencyInjectionException('Null can not be injected');
        }
        return resolve(injectionTarget, param);
    }

    private static Object resolve(Type injectionTarget, Object param){
        Binding dependencyBinding = bindingByTargetType.get(injectionTarget);
        if(dependencyBinding == null){
            throw new DependencyInjectionException('There is no registered dependency for ' + injectionTarget.getName());
        }
        Object mappedType = dependencyBinding.injectionType == DYNAMIC_BINDING
                ? resolveDynamic(dependencyBinding, param)
                : dependencyBinding.mappedType.newInstance();
        return mappedType;
    }

    private static Object resolveDynamic(Binding dependencyBinding, Object param){
        Object mappedClass = dependencyBinding.mappedType.newInstance();
        if(!(mappedClass instanceof IFactory)){
            throw new DependencyInjectionException(dependencyBinding.mappedType.getName() + ' requred to implement IFactory interface to be used in dynamic DI');
        }
        IFactory dependencyResolver = (IFactory)mappedClass;
        return dependencyResolver.retrieve(param);
    }

/*    private static void initDefaultBindings(){
        Binding typeBinding;
        Map<Type, Type> defaultInjectionConfigs = DIStaticConfig.getDefaultConfiguration();
        for(Type targetType : defaultInjectionConfigs.keySet()){
            typeBinding = createBinding(targetType, defaultInjectionConfigs.get(targetType), STATIC_BINDING);
            bindingByTargetType.put(typeBinding.targetType, typeBinding);
        }
    }*/

/*    private static void initBindings(){
        Binding typeBinding;
        for(Dependency_Binding__mdt dependencyBinding : [SELECT Interface_Name__c, Type__c, Mapped_Item__c FROM Dependency_Binding__mdt WHERE Is_Active__c = TRUE]){
            typeBinding = createBinding(dependencyBinding);
            bindingByTargetType.put(typeBinding.targetType, typeBinding);
        }
    }

    private static Binding createBinding(Dependency_Binding__mdt dependencyBinding){
        return createBinding(dependencyBinding.Interface_Name__c, dependencyBinding.Mapped_Item__c, dependencyBinding.Type__c);
    }*/

    private static Binding createBinding(String targetType, String mappedType, String injectionType){
        return createBinding(getTypeFromName(targetType), getTypeFromName(mappedType), injectionType);
    }

    private static Binding createBinding(Type targetType, Type mappedType, String injectionType){
        Binding typeBinding = new Binding();
        typeBinding.targetType = targetType;
        typeBinding.mappedType = mappedType;
        typeBinding.injectionType = injectionType;
        return typeBinding;
    }

    private static Type getTypeFromName(String typeName){
        Type typeForProvidedName = Type.forName(typeName);
        if(typeForProvidedName == null){
            throw new DependencyInjectionException(typeName + ' type is not valid');
        }
        return typeForProvidedName;
    }

    /**
    * @author Shokhanul Khok
    * @date 31/10/2018
    * @description Interface description for factory that specifies dynamic conditions for injection
    */
    public interface IFactory{
        /**
        * @author Shokhanul Khok
        * @date 31/10/2018
        * @description retrieves a dynamically defined implementation for target interface
        * @param param the value for condition to retrieve specific implementation
        * @return implementation for target interface
        */
        Object retrieve(Object param);
    }

    private class Binding{
        public Type targetType;
        public Type mappedType;
        public String injectionType;
    }

    public class DependencyInjectionException extends Exception{}
}