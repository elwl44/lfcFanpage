package com.example.lfcFan.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	// needToLoginInterceptor 인터셉터 불러오기
		@Autowired
		@Qualifier("needToLoginInterceptor")
		HandlerInterceptor needToLoginInterceptor;
	
	// beforeActionInterceptor 인터셉터 불러오기
		@Autowired
		@Qualifier("beforeActionInterceptor")
		HandlerInterceptor beforeActionInterceptor;

		// 이 함수는 인터셉터를 적용하는 역할을 합니다.
		@Override
		public void addInterceptors(InterceptorRegistry registry) {
			registry.addInterceptor(beforeActionInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
			.excludePathPatterns("/error");
			
			// 로그인 없이도 접속할 수 있는 URI 전부 기술
			registry.addInterceptor(needToLoginInterceptor).addPathPatterns("/**").excludePathPatterns("/resource/**")
					.excludePathPatterns("/").excludePathPatterns("/usr/article/home").excludePathPatterns("/usr/member/login")
					.excludePathPatterns("/usr/member/doLogin").excludePathPatterns("/usr/member/join").excludePathPatterns("/usr/member/idCheck")
					.excludePathPatterns("/usr/member/emailCheck").excludePathPatterns("/usr/member/doJoin").excludePathPatterns("/usr/article/notice")
					.excludePathPatterns("/usr/article/detail").excludePathPatterns("/error");
		}
}
