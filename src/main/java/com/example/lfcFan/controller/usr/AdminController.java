package com.example.lfcFan.controller.usr;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.lfcFan.dto.Article;
import com.example.lfcFan.dto.BanMember;
import com.example.lfcFan.dto.Member;
import com.example.lfcFan.service.AdminService;
import com.example.lfcFan.service.ArticleService;
import com.example.lfcFan.service.MemberService;
import com.example.lfcFan.util.Util;

@Controller
public class AdminController {
	@Autowired
	private ArticleService articleService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private AdminService adminService;

	@RequestMapping("/usr/admin/checkMember")
	public String checkMember(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param) {
		boolean isAdmin = (boolean) req.getAttribute("isAdmin");
		if (!isAdmin) {
			model.addAttribute("msg", "해당 게시판은 관리자만 이용 가능합니다.");
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}

		int totalCount = memberService.getTotalCount(param);
		int itemsCountInAPage = 10;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsCountInAPage);

		int pageMenuArmSize = 5;
		int page = Util.getAsInt(param.get("page"), 1);

		int pageMenuStart = page - pageMenuArmSize;
		if (pageMenuStart < 1) {
			pageMenuStart = 1;
		}
		int pageMenuEnd = page + pageMenuArmSize;
		if (pageMenuEnd > totalPage) {
			pageMenuEnd = totalPage;
		}

		param.put("itemsCountInAPage", itemsCountInAPage);

		List<Member> members = memberService.getForPrintMembers(param);
		articleService.getWrtieCountMembers(members);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("pageMenuArmSize", pageMenuArmSize);
		model.addAttribute("pageMenuStart", pageMenuStart);
		model.addAttribute("pageMenuEnd", pageMenuEnd);
		model.addAttribute("page", page);
		model.addAttribute("members", members);
		return "usr/admin/checkMember";
	}

	@RequestMapping("/usr/admin/banMember")
	public String showBanMember(HttpServletRequest req, Model model, @RequestParam Map<String, Object> param,
			@RequestParam(value = "id") List<String> _id) {
		List<Member> members = new ArrayList<Member>();
		List<BanMember> banmembers = adminService.getForPrintBanMembers();
		for (String id : _id) {
			Member member = (memberService.getMemberById(Util.getAsInt(id, 0)));
			members.add(member);
		}
		for (Member member : members) {
			for (BanMember banmember : banmembers) {
				if (member.getId() == banmember.getMemberid() && banmember.getStatus() == 1) {
					model.addAttribute("msg", String.format("이미 활동정지되었습니다."));
					model.addAttribute("popup_close", String.format("close"));
					model.addAttribute("historyBack", true);
					return "common/redirect";
				}
			}
		}
		model.addAttribute("members", members);
		return "usr/admin/banMember";
	}

	@RequestMapping("/usr/admin/doBanMember")
	public String doBanMember(HttpSession session, HttpServletRequest req, Model model, String listUrl,
			@RequestParam Map<String, Object> param, @RequestParam(value = "membersId") List<String> membersId) {

		adminService.addbanMemberById(membersId, param);

		model.addAttribute("msg", "회원탈퇴가 완료되었습니다.");
		model.addAttribute("popup_close", String.format("close"));
		return "common/redirect";
	}
}
