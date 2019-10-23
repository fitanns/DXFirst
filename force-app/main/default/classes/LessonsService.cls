/**
 * Created by DmytroPinchuk on 19.08.2019.
 */

public with sharing class LessonsService {

    public void formMap(List<sObject> newCourses) {

        List<Id> subjectsIds = ListUtility.getIds(Course__c.Subject__c, newCourses);

        Map<Id, Subject__c> subjectsById = new Map<Id, Subject__c>([
                SELECT Id, Number_Of_Lessons__c
                FROM Subject__c
                WHERE Id IN :subjectsIds
        ]);
        LessonsService service = new LessonsService();
        service.insertLessons(newCourses, subjectsById);
    }

    public void insertLessons(List<sObject> newCourses, Map<Id, Subject__c> subjectsById) {

        Set<Id> subIds = subjectsById.keySet();
        List<TimeSlot__c> timeSlots = [SELECT Id,DayOfWeek__c,Time__c,Subject__c FROM TimeSlot__c WHERE Subject__c IN :subIds];
        Map<Id, List<TimeSlot__c>> timeSlotsBySubjectIds = (Map<Id, List<TimeSlot__c>>)
                MapUtility.groupRecordByIds(TimeSlot__c.Subject__c, timeSlots, Map<Id, List<TimeSlot__c>>.class, List<TimeSlot__c>.class);
        LessonsService service = new LessonsService();
        List<Lesson__c> lessons = service.formLessonsList(newCourses, subjectsById, timeSlotsBySubjectIds);
        insert lessons;
    }

    public List<Lesson__c> formLessonsList(List<sObject> newCourses, Map<Id, Subject__c> subjectsById, Map<Id, List<TimeSlot__c>> timeSlotsBySubjectIds) {
        List<Lesson__c> lessons = new List<Lesson__c>();
        for (Course__c course : (List<Course__c>) newCourses) {
            Decimal lessonsDecimal = subjectsById.get(course.Subject__c).Number_Of_Lessons__c;
            List<TimeSlot__c> timeSl = timeSlotsBySubjectIds.get(course.Subject__c);
            Date startDate = course.Start_Date__c,
                    endDate = course.End_Date__c;
            Integer numberOfDays = startDate.daysBetween(endDate);

            LessonsService service = new LessonsService();
            lessons.addAll(service.validateAndForm(numberOfDays, lessonsDecimal, startDate, timeSl, course));
        }
        return lessons;
    }

    public List<Lesson__c> validateAndForm(Integer numberOfDays, Decimal lessonsDecimal, Date startDate, List<TimeSlot__c> timeSl, Course__c course) {
        List<Lesson__c> lessons = new List<Lesson__c>();
        Integer counterLessons = 0;
        for (Integer i = 0; i < numberOfDays; i++) {
            if (counterLessons == lessonsDecimal) {
                break;
            }
            Date currentDate = startDate.addDays(i);
            DateTime myDate = (DateTime) currentDate;
            String dayOfWeek = myDate.addDays(1).format('EEEE');

            for (TimeSlot__c timeSlot : timeSl) {
                if (dayOfWeek == timeSlot.DayOfWeek__c) {
                    Lesson__c lesson = new Lesson__c();
                    lesson.Course__c = course.Id;
                    lesson.Date__c = currentDate;
                    lesson.Time__c = timeSlot.Time__c;
                    lessons.add(lesson);

                    counterLessons++;
                }
            }
        }
        LessonsService service = new LessonsService();
        service.validateCoursesDate(counterLessons, lessonsDecimal, course);
        return lessons;
    }

/*    public List<Lesson__c> formingLessons(List<TimeSlot__c> timeSl, String dayOfWeek, Course__c course, Date currentDate) {

        List<Lesson__c> lessons = new List<Lesson__c>();
        for (TimeSlot__c timeSlot : timeSl) {
            if (dayOfWeek == timeSlot.DayOfWeek__c) {
                Lesson__c lesson = new Lesson__c();
                lesson.Course__c = course.Id;
                lesson.Date__c = currentDate;
                lesson.Time__c = timeSlot.Time__c;
                lessons.add(lesson);

                counterLessons++;
            }
        }
    }*/

    public void validateCoursesDate(Integer counterLessons, Decimal lessonsDecimal, Course__c course) {
        if (counterLessons != lessonsDecimal) {
            course.addError('You should choose more days for the correct distribution of lessons');
        }
    }
}