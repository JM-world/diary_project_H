package com.human.project_H.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.human.project_H.entity.TodayColor;
import com.human.project_H.service.TodayColorService;

import java.util.List;

@Controller
public class TodayColorController {

    @Autowired
    private TodayColorService todayColorService;

    @GetMapping("/select")
    public String selectColors(Model model) {
        List<TodayColor> todayColors = todayColorService.getTodayColorList(null, null, null);
        model.addAttribute("todayColors", todayColors);
        return "diary/selectColor";  // 
    }


}
