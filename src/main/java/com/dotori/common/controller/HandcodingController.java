package com.dotori.common.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class HandcodingController {
	
	@RequestMapping(value = "/coding.do")
    public String coding() {
        return "coding";
    }
 
    @RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
    public String insertBoard(String editor) {
        System.err.println("�˼����°� : " + editor);
        return "redirect:/coding.do";
    }
 
    // �������Ͼ��ε�
    @RequestMapping(value = "/file_uploader_html5.do",
                  method = RequestMethod.POST)
    @ResponseBody
    public String multiplePhotoUpload(HttpServletRequest request) {
        // �˼�����
        StringBuffer sb = new StringBuffer();
        try {
            // ���ϸ��� �޴´� - �Ϲ� �������ϸ�
            String oldName = request.getHeader("file-name");
            // ���� �⺻��� _ �󼼰��
            String filePath = "C:/uploadStorage/smartBoard/";
            String saveName = sb.append(new SimpleDateFormat("yyyyMMddHHmmss")
                          .format(System.currentTimeMillis()))
                          .append(UUID.randomUUID().toString())
                          .append(oldName.substring(oldName.lastIndexOf("."))).toString();
            
            
            InputStream is = request.getInputStream();
            OutputStream os = new FileOutputStream(filePath + saveName);
            int numRead;
            byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
            while ((numRead = is.read(b, 0, b.length)) != -1) {
                os.write(b, 0, numRead);
            }
            os.flush();
            os.close(); 
            // �˼�����
            sb = new StringBuffer();
            sb.append("&bNewLine=true")
              .append("&sFileName=").append(oldName)
              .append("&sFileURL=").append("http://192.168.0.120:8080/uploadStorage/smartBoard/")
        .append(saveName);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

}
