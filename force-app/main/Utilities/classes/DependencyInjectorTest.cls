/**
 * Created by Shokhanul Khok on 31.10.2018.
 */
@isTest
public class DependencyInjectorTest {

    @IsTest
    static void testGetStaticDependency() {
        DependencyInjector.overrideByStatic(IMessanger.class, TelegramMessanger.class);
        Test.startTest();
        IMessanger messanger = (IMessanger) DependencyInjector.getInstance(IMessanger.class);
        Test.stopTest();
        System.assert(messanger instanceof TelegramMessanger, 'Registered instance should be returned');
    }

    @IsTest
    static void testGetInstanceWithMissingTypeException() {
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            IMessanger messanger = (IMessanger) DependencyInjector.getInstance(null, null);
        } catch (DependencyInjector.DependencyInjectionException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        System.assert(isExceptionThrown, 'Null can not be injected');
    }

    @IsTest
    static void testGetDynamicDependency() {
        DependencyInjector.overrideByDynamic(IMessanger.class, MessangerDependencyResolver.class);
        Test.startTest();
        IMessanger messanger = (IMessanger) DependencyInjector.getInstance(IMessanger.class, 'Viber');
        Test.stopTest();
        System.assert(messanger instanceof ViberMessanger, 'Messanger implementation should match messanger name');
    }

    @IsTest
    static void testGetDynamicDependencyWithWrongInstance() {
        DependencyInjector.overrideByDynamic(IMessanger.class, TestDataFactory.class);
        Boolean isExceptionThrown = false;
        Test.startTest();
        try {
            IMessanger messanger = (IMessanger) DependencyInjector.getInstance(IMessanger.class, 'Viber');
        } catch (DependencyInjector.DependencyInjectionException e) {
            isExceptionThrown = true;
        }
        Test.stopTest();
        System.assert(isExceptionThrown, 'Mapped type must implement IFactory interface to be used in dynamic DI');
    }

    @IsTest
    static void testGetDynamicDependencyWhenBindingNotSpecified() {
        Boolean isFailed = false;
        Test.startTest();
        try {
            IMessanger messanger = (IMessanger) DependencyInjector.getInstance(IMessanger.class, 'Viber');
        } catch (DependencyInjector.DependencyInjectionException e) {
            isFailed = true;
        }
        Test.stopTest();
        System.assert(isFailed, 'Injector should throw an exception when binding not registered');
    }

    public interface IMessanger {
        void sendMessage();
    }

    public class TelegramMessanger implements IMessanger {
        public void sendMessage() {
            System.debug('Hello world sent via Telegram');
        }
    }

    public class ViberMessanger implements IMessanger {
        public void sendMessage() {
            System.debug('Hello world sent via Viber');
        }

    }

    public class MessangerDependencyResolver implements DependencyInjector.IFactory {
        public Object retrieve(Object param) {
            String messangerName = (String) param;
            Type messangerType;
            if (messangerName == 'Viber') {
                messangerType = ViberMessanger.class;
            } else {
                messangerType = TelegramMessanger.class;
            }
            return messangerType.newInstance();
        }
    }
}