using System;

class Program
{
    const int MAX = 100;

    static int Sum(int[] numbers)
    {
        int result = 0;
        foreach (int number in numbers)
        {
            result += number;
        }
        return result;
    }

    static int GetValidInteger(string prompt, int min, int max)
    {
        int value;
        while (true)
        {
            Console.Write(prompt);
            if (int.TryParse(Console.ReadLine(), out value) && value >= min && value <= max)
            {
                return value;
            }
            Console.WriteLine($"Invalid input. Please enter a number between {min} and {max}.");
        }
    }

    static int[] GetIntegerArray(int size)
    {
        int[] numbers = new int[size];
        for (int i = 0; i < size; i++)
        {
            numbers[i] = GetValidInteger($"Enter integer {i + 1}: ", int.MinValue, int.MaxValue);
        }
        return numbers;
    }

    static void Main()
    {
        try
        {
            int numberOfElements = GetValidInteger("Enter the number of elements (1-100): ", 1, MAX);
            int[] numbers = GetIntegerArray(numberOfElements);
            int total = Sum(numbers);
            Console.WriteLine("Sum of the numbers: " + total);
        }
        catch (Exception ex)
        {
            Console.WriteLine("An unexpected error occurred: " + ex.Message);
        }
    }
}