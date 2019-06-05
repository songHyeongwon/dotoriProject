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
	/*어노테이션 @AllArgsConstructor = 모든 필드변수를 의존성 주입시켜준다. 아니면 Setter쓰시던가*/
	private Cs_BoardService cs_boardService;
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글쓰기 폼-----------------------------------------------------------
	@RequestMapping(value="/cs_writeForm")
	public String cs_writeForm(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		
		return "cs_board/cs_writeForm";
	}
	//------------------------------------글쓰기 폼-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------사진 URL복사-----------------------------------------------------------
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
	//------------------------------------사진 URL복사-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------게시글 등록-----------------------------------------------------------
	@RequestMapping(value="/cs_boardInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute Cs_BoardVO bvo, Model model) {
		log.info("boardInsert 호출 성공");
		
		bvo.setEditor(bvo.getEditor().replaceAll("uploadStorage/", "uploadStorage/cs_board/"+getFolder("C:\\uploadStorage").replace("\\", "/")+"/"));
		bvo.setEditor(bvo.getEditor().replaceAll("&nbsp;",""));
		
		int result = 0;
		String url ="";
		bvo.setT_editor(bvo.getEditor().replaceAll("[<][^>]*[>]", " ").trim());
		System.out.println(bvo.getT_editor());
		//임시 ID 닉네임----------------------------------------
		bvo.setCs_name("testName");
		bvo.setMember_id("testid");
		result = cs_boardService.cs_boardInsert(bvo);
		
		if(result == 1) {
			url ="/cs_board/cs_boardDetail_curr";
		}
		
		//redirect: 를 쓰면 스프링 내부에서 자동적으로 response.sendRedirect(url)를 호출해준다.
		return "redirect:"+url;
	}
	//------------------------------------게시글 등록-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글 상세정보-----------------------------------------------------------
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
	//------------------------------------글 상세정보-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------
	//------------------------------------글 목록-----------------------------------------------------------
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
		
		//전체 레코드 수 구현
		int total = cs_boardService.cs_boardListCnt(bvo);
		model.addAttribute("pageMaker",new PageDTO(bvo,total));
		
		return "cs_board/cs_boardList";
	}
	//------------------------------------글 목록-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------업데이트 뷰-----------------------------------------------------------
	@RequestMapping(value="/cs_updateForm")
	public String updateForm(@ModelAttribute("data") Cs_BoardVO bvo,@RequestParam("cs_num") int cs_num, Model model) {
		
		Cs_BoardVO cs_updateDate = cs_boardService.cs_updateForm(cs_num);
		
		model.addAttribute("cs_updateData", cs_updateDate);
		return "cs_board/cs_updateForm";
	}
	
	//------------------------------------업데이트 뷰-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------

	//--------------------------------------------------------------------------------------------------------
	//------------------------------------데이터 업데이트-----------------------------------------------------------
	@RequestMapping(value="/cs_boardUpdate", method=RequestMethod.POST)
	public String updateForm(@ModelAttribute Cs_BoardVO bvo, RedirectAttributes ras) {
		log.info("boardUpdate 호출 성공");
		
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
	//------------------------------------데이터 업데이트-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	//------------------------------------데이터 삭제-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/cs_boardDelete")
	public String boardDelete(@ModelAttribute Cs_BoardVO bvo) {
		log.info("boardDelete 호출 성공");
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
		log.info("replyCnt 호출 성공");
		int result = 0;
		result = cs_boardService.cs_replyCnt(cs_num);
		return result+"";
	}

	
	//------------------------------------데이터 삭제-----------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------
	
	
/*	


	//글목록 구현하기
	@RequestMapping(value="/boardList",method=RequestMethod.GET)
	public String boardList(@ModelAttribute("data") Cs_BoardVO bvo,Model model) {
		log.info("boardList 호출 성공");
		//log.info("keyword : "+bvo.getKeyword());
		//log.info("search : "+bvo.getSearch());
		
		
		List<Cs_BoardVO> boardList = boardService.boardList(bvo);
		model.addAttribute("boardList",boardList);
		
		//전체 레코드 수 구현
		int total = boardService.boardListCnt(bvo);
		//int to = boardList.size();
		//이래도 되지 않나? = 검색하면 10개 단위로만 가져와서 안돼더라~~
		model.addAttribute("pageMaker",new PageDTO(bvo,total));
		return "board/boardList";
	}
	
	/////////////////////////////////////////////////////////
	
	
	/////////////////////////////////////////////////////////
	//글 insert 구현하기
	*/
}
