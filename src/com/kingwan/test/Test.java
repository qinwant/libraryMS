package com.kingwan.test;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.kingwan.entity.Reader;
import com.kingwan.utils.GokJDBCUtil;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;

/**
 * Created by kingwan on 2020/4/12.
 */
public class Test {
    public static void main(String[] args) {
        HashMap<String,Object> map = new HashMap<>();
        map.put("msg","");
        map.put("code", 0);
        List<Reader> readerList = GokJDBCUtil.queryAll("select * from reader", Reader.class);
        map.put("data",readerList);
        if(readerList!=null){
            Object jsonData = JSON.toJSON(map);
            createJsonFile(jsonData,"test/jsonData.json");
        }

    }
    /**
     * 将JSON数据格式化并保存到文件中
     * @param jsonData 需要输出的json数
     * @param filePath 输出的文件地址
     * @return
     */
    public static boolean createJsonFile(Object jsonData, String filePath) {
        String content = JSON.toJSONString(jsonData, SerializerFeature.PrettyFormat, SerializerFeature.WriteMapNullValue,
                SerializerFeature.WriteDateUseDateFormat);
        // 标记文件生成是否成功
        boolean flag = true;
        // 生成json格式文件
        try {
            // 保证创建一个新文件
            File file = new File(filePath);
            if (!file.getParentFile().exists()) { // 如果父目录不存在，创建父目录
                file.getParentFile().mkdirs();
            }
            if (file.exists()) { // 如果已存在,删除旧文件
                file.delete();
            }
            file.createNewFile();
            // 将格式化后的字符串写入文件
            Writer write = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
            write.write(content);
            write.flush();
            write.close();
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
        }
        return flag;
    }
}
