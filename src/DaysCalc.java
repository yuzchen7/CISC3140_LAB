import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

@SuppressWarnings(value = { "resource" })
public class DaysCalc {

    /**
     * Static variables are initialized when is loading the class and saved in method zone,
     * which all java process in current JVM process are sharing those variables
     */
    static SimpleDateFormat simpleDateFormat1;
    static SimpleDateFormat simpleDateFormat2;
    
    /**
     * Static Block
     * it will run when jvm is loading the class, 
     * which is before any other method(including main method) 
     * has been called/executed 
     */
    static {
        simpleDateFormat1 = new SimpleDateFormat("MM/dd/yyyy");
        simpleDateFormat2 = new SimpleDateFormat("MM-dd-yyyy");
        simpleDateFormat1.setLenient(false);
        simpleDateFormat2.setLenient(false);
    }

    public static void main(String[] args) throws IOException {
        // Scanner inputScanner = null;
        Map<String, ArrayList<Date>> datesMap = null;
        Scanner keybordInput = new Scanner(System.in);
        String startDateStr, endDateStr;
        datesMap = null;
        try {
            datesMap = savedDates("src/Date.txt");
        } catch (Exception e) {
            datesMap = savedDates("Date.txt");
        }

        System.out.println();
        printDateMeun(datesMap); // print all the dates
        System.out.println();

        do {
            try {
                System.out.println("Enter the date in format either in 'MM/DD/YYY' or 'MM-DD', \nOr choose a Date from above in format 'xxx_date index'");
                System.out.print("From date : ");
                startDateStr = keybordInput.nextLine().trim();
                System.out.println(startDateStr);
                Date startDate = inputDateMake(startDateStr, datesMap);
                if (startDate == null) { // date construct failed, which means there is invaild input
                    throw new Exception(); // throws exception for going into next round of loop
                }

                System.out.print("To date : ");
                endDateStr = keybordInput.nextLine().trim();
                System.out.println(endDateStr);
                Date endDate = inputDateMake(endDateStr, datesMap);
                if (endDate == null) { // date construct failed, which means there is invaild input
                    throw new Exception(); // throws exception for going into next round of loop
                }

                int resultInDay = dateCalculator(startDate, endDate);

                // print out the number of days resultInDay
                if (resultInDay == 0) {
                    System.out.println("Today is the due Date, please submit the work.\n\n");
                    continue;
                
                } else if (resultInDay == -1) {
                    System.out.println("The date is passed.\n\n");
                    continue;

                } else {
                    System.out.println(resultInDay + " days alway form today\n\n");
                }

                System.out.println("---------------------------------");

            } catch (Exception e) {
                System.out.println("invaild input date format, please re-enter your input\n");
                continue;
            }
        } while (true);
    }

    /**
     * Make a Date Object based on the input String, return null if Date object construct failed
     * In addition, method will detect if input is an exit command, if yes, then exit the whole 
     * process with exit code 0
     * @param dateStr   input date format
     * @param datesMap  The map stored all the saved dates
     * @return Date if init a Date successfully, otherwise return null
     * @throws ParseException
     */
    public static Date inputDateMake(String dateStr, Map<String, ArrayList<Date>> datesMap) throws ParseException {
        Date date = null;
        if (dateStr.equalsIgnoreCase("exit")) { // check for exit the program, any
            System.out.println("Program end....");
            System.exit(0);
        }
        
        switch (checkFormatOf(dateStr)) {
            case 0 :
            case 1 : { // case 0 ~ 1 share the same logic of code, which input is in date format
                date = makeDate(dateStr);
                break;
            }
            case 2 : { // case 2 which input is in date format, handle input to get data from map
                String[] inputs = dateStr.split(" ");
                ArrayList<Date> dateList = datesMap.get(inputs[0]);
                if (dateList != null) {
                    date = dateList.get(Integer.parseInt(inputs[1]));
                }
            }
        }

        return date; // return null if Date object construct failed
    }

    /**
     * Calculate how many days between to date, and return the number of dates.
     * @param startDay starting date want to calculate for
     * @param endDate  endding date want to reach for
     * @return number of dates between starting date to endding day;
     *         return 0 represents in the same day;
     *         return -1 represents the endding date already pass
     */
    public static int dateCalculator(Date startDay, Date endDate) {
        // since date.getTime() is returning the milliseconds to represent for,
        // so '/ 1000 / 60 / 60 / 24' to convert milliseconds to days
        double resultInDay = (double) (endDate.getTime() - startDay.getTime()) / 1000 / 60 / 60 / 24;

        // days betwen 0 ~ 1 means startDay and endDate are in the same day
        if (resultInDay <= 0 && resultInDay > -1) {
            return 0;
        }

        // days less than or equal to -1 means the end date is already pass
        if (resultInDay <= -1) {
            return -1;
        }

        return (int) Math.ceil(resultInDay); // otherwise, the number of days
    }

    /**
     * Return a Date object base on the input String, if string fromat not match 
     * 'MM/DD/YYYY' or 'MM-DD', then return a null.
     * @param date  date in String type, that want to parse to Date
     * @return  Date object represent by the date String, if not match the 
     * @throws ParseException   error parse String to Date
     */
    public static Date makeDate(String date) throws ParseException {
        if (date.matches("\\d{1,2}/\\d{1,2}/\\d{4}")) {
            return simpleDateFormat1.parse(date);
        }

        if (date.matches("\\d{1,2}-\\d{1,2}")) { // match the format with 'MM-DD'
            Calendar calendar = Calendar.getInstance();
            int currentYear = calendar.get(Calendar.YEAR);
            Date reslut = simpleDateFormat2.parse(date + "-" + currentYear); // make date Obj
            calendar.setTime(reslut);

            //to check if the date is already passed, if yes, then set date's year to next year
            if (dateCalculator(new Date(System.currentTimeMillis()), reslut) == -1) {
                calendar.set(Calendar.YEAR, currentYear + 1);
            }

            return calendar.getTime();
        }

        return null; // otherwise return null for construct Date object failed
    }

    /**
     * read in all the dates has been saved at a record file, return the map
     * that contains all the dates and map the dates descriptions 
     * @param filename file read in from
     * @return  the hash map structure that contains all the dates and map the dates descriptions
     * @throws IOException Input/Output Stream Exception if file exceptions
     */
    public static Map<String, ArrayList<Date>> savedDates(String filename) throws IOException {
        Scanner inputDate = new Scanner(new File(filename));
        String inputKey, dateString;
        Date date;
        int counter;
        ArrayList<Date> datesList;
        Map<String, ArrayList<Date>> datesMap = new HashMap<>();

        while (inputDate.hasNext()) {
            inputKey = inputDate.next();
            counter = inputDate.nextInt();
            datesList = new ArrayList<>(counter);
            for (int i = 0; i < counter; i++) {
                dateString = inputDate.next();
                try {
                    date = makeDate(dateString);
                    datesList.add(date);
                } catch (ParseException e) {
                    continue;
                }
            }

            datesMap.put(inputKey, datesList);
        }    
        return datesMap;    
    }
    
    /**
     * print out all the saved dates by using two for each loop
     * @param datesMap the map of dates
     */
    public static void printDateMeun(Map<String, ArrayList<Date>> datesMap) {
        for (Map.Entry<String, ArrayList<Date>> entry : datesMap.entrySet()) {
            System.out.print(entry.getKey() + " -> [");
            ArrayList<Date> list = entry.getValue();
            for (int i = 0; i < list.size(); i++) {
                System.out.print(simpleDateFormat1.format(list.get(i)));
                if (i != list.size() - 1) {
                    System.out.print(", ");
                }
            }
            System.out.println("]");
        }
    }
 
    /**
     * Check the str format if it is a valid date format or map search format
     * @param str input string
     * @return a int representing the format of the date
     */
    public static int checkFormatOf(String str) {
        if (str.matches("\\d{1,2}/\\d{1,2}/\\d{4}")) {
            return 0;
        } else if (str.matches("\\d{1,2}-\\d{1,2}")) {
            return 1;
        } else if (str.matches("[A-Za-z_]{1,} [0-9]{1,}")){
            return 2;
        } else {
            return -1;
        }
    }
}
