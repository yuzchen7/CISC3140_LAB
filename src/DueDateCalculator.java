import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;

@SuppressWarnings(value = {"resource"})
public class DueDateCalculator {
    public static void main(String[] args) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        dateFormat.setLenient(false);
        Scanner input = new Scanner(System.in);
        Date current = new Date();
        String dueDateString;

        System.out.print("Enter the due date with format 'mm/dd/yyyy' : ");
        dueDateString = input.next();

        System.out.print("Result -> ");

        try {
            Date dueDate = dateFormat.parse(dueDateString); 
            double resultInDay = (double)(dueDate.getTime() - current.getTime()) / 1000 / 60 /60 / 24;
            
            if (resultInDay <= 0 && resultInDay > -1) {
                System.out.println("Today is the due Date, please submit the work.");
                return;
            } 

            if (resultInDay <= -1) {
                System.out.println("The due date is passed.");
                return;
            }

            System.out.println((int)Math.ceil(resultInDay) + " days alway form today");

        } catch (ParseException e) {
            System.out.println("The enter date is invalid");
        }
    }
}