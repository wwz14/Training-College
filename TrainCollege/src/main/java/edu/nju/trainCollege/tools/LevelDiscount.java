package edu.nju.trainCollege.tools;

import java.util.Date;

public class LevelDiscount {

    private static final int[] EXPR_THRESHOLD = {100,300,800,2000,5000,10000};
    private static final double[] DISCOUNT_THRESHOLD = {0.98,0.95,0.93,0.9,0.88,0.85,0.8};
    private static final int[] TIME_THRESHOLD = {0,30,90};
    private static final double[] COMP_THRESHOLD = {0,0.5,0.8,1};

    public static int getLevel(int expr){
        int i;
        for(i = 0;i<EXPR_THRESHOLD.length;i++){
            if(expr<EXPR_THRESHOLD[i])
                return i+1;
        }
        return i+2;
    }

    public static double getDiscount(int expr){
        int i;
        for(i = 0;i<EXPR_THRESHOLD.length;i++){
            if(expr<EXPR_THRESHOLD[i])
                return DISCOUNT_THRESHOLD[i];
        }
        return DISCOUNT_THRESHOLD[i+1];
    }

    public static double getCompensation(Date startDay){
        int days = new Long((startDay.getTime()-new Date().getTime())/(1000*60*60*24)).intValue();
        int i ;
        for(i = 0;i<TIME_THRESHOLD.length;i++){
            if(days<TIME_THRESHOLD[i])
                return COMP_THRESHOLD[i];
        }
        return COMP_THRESHOLD[i+1];
    }

    public static int[] getExprThreshold(){
        return EXPR_THRESHOLD;
    }

    public static double[] getDiscountThreshold(){
        return DISCOUNT_THRESHOLD;
    }
}
