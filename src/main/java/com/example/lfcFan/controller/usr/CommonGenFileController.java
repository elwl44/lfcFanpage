package com.example.lfcFan.controller.usr;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.example.lfcFan.dto.ResultData;
import com.example.lfcFan.service.GenFileService;

@Controller
public class CommonGenFileController {
	@Autowired
	private GenFileService genFileService;
	
	@RequestMapping("/common/genFile/doUpload")
	@ResponseBody
	public ResultData doUpload(@RequestParam Map<String, Object> param, MultipartRequest multipartRequest) {
		System.out.println("in--------");
		return genFileService.saveFiles(param, multipartRequest);
	}
}