package com.dotori.common.controller;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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
        System.err.println("���옣�븷 �궡�슜 : " + editor);
        return "redirect:/coding.do";
    }
 
    // �떎以묓뙆�씪�뾽濡쒕뱶
    @RequestMapping(value = "/file_uploader_html5.do", method = RequestMethod.POST)
    @ResponseBody
    public String multiplePhotoUpload(HttpServletRequest request) {
        // �뙆�씪�젙蹂�
        StringBuffer sb = new StringBuffer();
        try {
            // �뙆�씪紐낆쓣 諛쏅뒗�떎 - �씪諛� �썝蹂명뙆�씪紐�
            String oldName = request.getHeader("file-name").replaceAll("%20", " ");
            // �뙆�씪 湲곕낯寃쎈줈 _ �긽�꽭寃쎈줈
            
            String filePath = "C:/uploadStorage/";
            				//"D:/workspace/Spring/src/main/webapp/resources/photoUpload/";
            String saveName = sb.append(UUID.randomUUID().toString())
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
            // �젙蹂� 異쒕젰
            sb = new StringBuffer();
            sb.append("&bNewLine=true")
              .append("&sFileName=").append(oldName)
              .append("&sFileURL=").append("http://192.168.0.120:8080/uploadStorage/")
              .append(saveName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

}
