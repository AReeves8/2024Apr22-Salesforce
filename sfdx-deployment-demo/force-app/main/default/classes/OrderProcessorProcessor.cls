public with sharing class OrderProcessorProcessor {
    public OrderProcessorProcessor() {

    }


    public static Boolean process() {
        Integer randomNumber = Integer.valueof(Math.random() * 100);    // random number from 0-100

        if(Math.mod(randomNumber, 2) == 0) {
            // if even number, return true
            return true;
        }

        // else return false
        return false;
    }
}