package com.dotori.client.cs_board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dotori.client.cs_board.service.Cs_BoardService;
import com.dotori.client.cs_board.vo.Cs_BoardVO;
import com.dotori.common.vo.PageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/cs_board/*")
@Log4j
@AllArgsConstructor
public class Cs_BoardController{
	/*�뼱�끂�뀒�씠�뀡 @AllArgsConstructor = 紐⑤뱺 �븘�뱶蹂��닔瑜� �쓽議댁꽦 二쇱엯�떆耳쒖��떎. �븘�땲硫� Setter�벐�떆�뜕媛�*/
	private Cs_BoardService cs_boardService;
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲��벐湲� �뤌-----------------------------------------------------------
	@RequestMapping(value="/cs_writeForm")
	public String cs_writeForm(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		
		return "cs_board/cs_writeForm";
	}
	//------------------------------------湲��벐湲� �뤌-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�궗吏� URL蹂듭궗-----------------------------------------------------------
	@RequestMapping(value="/cs_writeFormAction", method=RequestMethod.POST)
	public String cs_writeFormAction(@RequestParam("cs_html") String html,RedirectAttributes redirectAttributes) {
		String value = html;
		String fileName = "";
		ArrayList<String> array = new ArrayList<>();
		InputStream is = null;
		OutputStream os= null;
		while(value.indexOf("<img src=\"")!=-1) {
			value = value.substring(value.indexOf("<img src=\"")+10);
			fileName = value.substring(0, value.indexOf("\""));
			fileName = fileName.substring(fileName.lastIndexOf("/")+1);
			array.add(fileName);
		}

		String uploadStorage = "C:\\uploadStorage";
		String detailPath = getFolder(uploadStorage+"\\cs_board");
		try {
			for(int i = 0; i < array.size();i++) {					
				File file = new File(uploadStorage +"\\"+ array.get(i));
				Integer filesize = (int) file.length();
		        is = new FileInputStream(uploadStorage.replace("\\", "/") +"/"+ array.get(i));
		        os = new FileOutputStream(uploadStorage.replace("\\", "/") + "/cs_board/" + detailPath.replace("\\", "/") + "/" + array.get(i));
		        int numRead;
		        byte b[] = new byte[filesize];
		        while ((numRead = is.read(b, 0, b.length)) != -1) {
		            os.write(b, 0, numRead);
		        }
		        os.flush();
		        os.close();							
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 		
		return "redirect:/cs_board/cs_writeForm";
	}
	
	private String getFolder(String folder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date).replaceAll("-", "\\\\");	
		File uploadPath = new File(folder,str);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		return str;
	}
	//------------------------------------�궗吏� URL蹂듭궗-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------
	@RequestMapping(value="/cs_boardInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute Cs_BoardVO bvo, Model model) {
		log.info("boardInsert �샇異� �꽦怨�");
		
		bvo.setEditor(bvo.getEditor().replaceAll("uploadStorage/", "uploadStorage/cs_board/"+getFolder("C:\\uploadStorage").replace("\\", "/")+"/"));
		bvo.setEditor(bvo.getEditor().replaceAll("&nbsp;",""));
		
		int result = 0;
		String url ="";
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		System.out.println(bvo.getT_editor());
		//�엫�떆 ID �땳�꽕�엫----------------------------------------
		bvo.setCs_name("testName");
		bvo.setMember_id("testid");
		result = cs_boardService.cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		
		//redirect: 瑜� �벐硫� �뒪�봽留� �궡遺��뿉�꽌 �옄�룞�쟻�쑝濡� response.sendRedirect(url)瑜� �샇異쒗빐以��떎.
		return "redirect:"+url;
	}
	//------------------------------------寃뚯떆湲� �벑濡�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------
	@RequestMapping(value="/cs_boardDetail", method=RequestMethod.GET)
	public String cs_boardDetail(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		Cs_BoardVO cs_detail = cs_boardService.cs_boardDetail(bvo.getCs_num());

		model.addAttribute("cs_detail",cs_detail);
		
		return "cs_board/cs_boardDetail";
	}
	
	@RequestMapping(value="/cs_boardDetail_curr", method=RequestMethod.GET)
	public String cs_boardDetail_curr(RedirectAttributes redirectAttributes) {
		Cs_BoardVO cs_detail = cs_boardService.cs_boardDetail(cs_boardService.cs_boardDetail_currnum());
		redirectAttributes.addFlashAttribute("data",cs_detail);
		
		return "redirect:/cs_board/cs_boardDetail";
	}
	//------------------------------------湲� �긽�꽭�젙蹂�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	@RequestMapping(value="/cs_boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
				
		List<Cs_BoardVO> cs_boardList = cs_boardService.cs_boardList(bvo);
		for(int i = 0; i < cs_boardList.size();i++) {
			String str = cs_boardList.get(i).getEditor();
			if(str.indexOf("<img src=\"")!=-1) {
				str = str.substring(str.indexOf("<img src=\""));
				str = str.substring(0, str.indexOf("\">")+2);
				cs_boardList.get(i).setEditor(str);
			} else {
				cs_boardList.get(i).setEditor("");				
			}
		}
		
		model.addAttribute("cs_boardList",cs_boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = cs_boardService.cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total,10));
		
		return "cs_board/cs_boardList";
	}
	//------------------------------------湲� 紐⑸줉-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	@RequestMapping(value="/cs_updateForm")
	public String updateForm(@ModelAttribute("data") Cs_BoardVO bvo,@RequestParam("cs_num") int cs_num, Model model) {
		
		Cs_BoardVO cs_updateDate = cs_boardService.cs_updateForm(cs_num);
		
		model.addAttribute("cs_updateData", cs_updateDate);
		return "cs_board/cs_updateForm";
	}
	
	//------------------------------------�뾽�뜲�씠�듃 酉�-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------
	@RequestMapping(value="/cs_boardUpdate", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute Cs_BoardVO bvo, RedirectAttributes ras) {
		log.info("boardUpdate �샇異� �꽦怨�");
		
		int result = 0;
		String url = "";
		
		result = cs_boardService.cs_boardUpdate(bvo);
		ras.addFlashAttribute("data",bvo);
		
		if(result==1) {
			url="/cs_board/cs_boardDetail";
		}else {
			url="/cs_board/cs_updateForm";
		}
		return "redirect:"+url;
	}
	//------------------------------------�뜲�씠�꽣 �뾽�뜲�씠�듃-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/cs_boardDelete")
	public String boardDelete(@ModelAttribute Cs_BoardVO bvo) {
		log.info("boardDelete �샇異� �꽦怨�");
		int result = 0;
		String url = "";
		//		result = boardService.boardDelete(bvo.getB_num());
		
		if(result ==1) {
			url="/cs_board/cs_boardList";
		}else {
			//url="/board/boardDetail?b_num="+bvo.getB_num();
		}
		
		return "redirect:"+url;
	}
	
	@ResponseBody
	@RequestMapping(value="/replyCnt")
	public  String replyCnt(@RequestParam("cs_num") int cs_num) {
		log.info("replyCnt �샇異� �꽦怨�");
		int result = 0;
		result = cs_boardService.cs_replyCnt(cs_num);
		return result+"";
	}

	
	//------------------------------------�뜲�씠�꽣 �궘�젣-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
/*	


	//湲�紐⑸줉 援ы쁽�븯湲�
	@RequestMapping(value="/boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		log.info("boardList �샇異� �꽦怨�");
		//log.info("keyword : "+bvo.getKeyword());
		//log.info("search : "+bvo.getSearch());
		
		
		List<Cs_BoardVO> boardList = boardService.boardList(bvo);
		model.addAttribute("boardList",boardList);
		
		//�쟾泥� �젅肄붾뱶 �닔 援ы쁽
		int total = boardService.boardListCnt(bvo);
		//int to = boardList.size();
		//�씠�옒�룄 �릺吏� �븡�굹? = 寃��깋�븯硫� 10媛� �떒�쐞濡쒕쭔 媛��졇���꽌 �븞�뤌�뜑�씪~~
		model.addAttribute("pageMaker",new PageDTO(bvo,total));
		return "board/boardList";
	}
	
	/////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////
	//湲� insert 援ы쁽�븯湲�
	*/
}
