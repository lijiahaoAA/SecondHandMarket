package com.ldu.util;

import java.security.MessageDigest;

/**
 * @Author: lijiahao
 * @Description: 用于密码加密
 * @Data: Create in 22:20 2020/3/14
 * @Modified By:
 */
public final class MD5 {

    /**
     * Md5加密
     * @param s
     * @return
     */
    public final static String md5(String s) {
        char hexDigits[] = { '0', '1', '2', '3', '4',
                '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F'};
        try {
            //传过来的密码参数转化为字节数组，一个中文字符=2字节=16位
            byte[] btInput = s.getBytes();
            //获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            //使用指定的字节更新摘要
            mdInst.update(btInput);
            //获得密文
            byte[] md = mdInst.digest();
            //把密文转换成十六进制的字符串形式
            int j = md.length;
            //1个char=2byte=16bit
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                //byte0右移四位，其他用0补齐。字节中高四位数字转换。 11011111=>00001101 相当于保留前四位 1byte=8bit
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                //byte0 与 0xf进行按位与运算，byte=>char 自动转型。字节中第四位的数字转换。
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        System.out.println(MD5.md5("967042"));
    }
}
