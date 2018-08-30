package edu.nju.trainCollege.tools;

import java.util.LinkedList;
import java.util.List;

public class NumberTool {
    public static List<Integer> getAllNumbers(String s){
        List<Integer> result = new LinkedList<Integer>();
        int current = 0;
        boolean isNum = false;
        for(char c:s.toCharArray()){
            if(c>='0'&&c<='9'){
                current = current*10+c-'0';
                isNum=true;
            }else if(isNum){
                result.add(current);
                current=0;
                isNum=false;
            }
        }
        return result;
    }

//    public static void main (String[] args){
//        List<Integer> result = getAllNumbers(" 403人/班 × 55个班");
//        for(int i = 0;i<result.size();i++){
//            System.out.print(result.get(i)+" ");
//        }
//    }
}
