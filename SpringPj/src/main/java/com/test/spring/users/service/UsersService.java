package com.test.spring.users.service;

import com.test.spring.users.dto.UsersDto;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

public interface UsersService {
    public void addUser(UsersDto dto);
    public void loginProcess(UsersDto dto, HttpSession session);
    public void getInfo(HttpSession session, ModelAndView mView);
    public void updateUserPwd(HttpSession session, UsersDto dto, ModelAndView mView);
    public Map<String, Object> saveProfileImage(HttpServletRequest request,
                                                MultipartFile mFile);
    public void updateUser(UsersDto dto, HttpSession session);
    public void deleteUser(HttpSession session, ModelAndView mView);
}
