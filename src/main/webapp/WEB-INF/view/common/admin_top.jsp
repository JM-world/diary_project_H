<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
     <!-- Navbar Brand-->
        <h4 style="font-weight: bold; font-family: 'Hi Melody', sans-serif;">
            <a class="navbar-brand ps-3" href="/project_H/home" style="text-decoration: none; color: white;" 
            onmouseover="this.style.color='pink'" onmouseout="this.style.color='white'">"오늘의 컬러, 오늘의 기분"</a>
        </h4>
     <!-- Sidebar Toggle-->
     <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
     <!-- Navbar-->
     <ul class="navbar-nav ms-auto">
        <li class="nav-item me-3">
            <a id = "diary" href="/project_H/diary/color" class="nav-link btn btn-outline-secondary" title="일기 쓰기"
                data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                <i class="fas fa-edit"></i>
            </a>
        </li>
        <li class="nav-item me-3">
            <a id="calendarLink" href="/project_H/calendar" class="nav-link btn btn-outline-secondary"
                title="캘린더 보기" data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
                <i class="fas fa-calendar"></i>
            </a>
        </li>
        <li class="nav-item me-3">
            <a id="myDiaryLink" href="/project_H/diary/diarylist" class="nav-link btn btn-outline-secondary"
                title="내가 쓴 일기" data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip"
                data-bs-placement="bottom">
                <i class="fas fa-book"></i>
            </a>
        </li>
        <li class="nav-item me-3">
            <a id = "boardLink" href="/project_H/board/list/1" class="nav-link btn btn-outline-secondary" title="자유게시판"
                data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
            <i class="fas fa-list-alt"></i>
            </a>
        </li>
        <li class="nav-item me-3">
            <a id = "boardLink2" href="/project_H/diary/list/1" class="nav-link btn btn-outline-secondary" title="공유게시판"
                data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
            <i class="far fa-list-alt"></i>
            </a>
            </li>
        <li class="nav-item me-3">
            <a href="/project_H/api/local" class="nav-link btn btn-outline-secondary" title="상담센터 지도"
                data-bs-custom-class="tooltip-light-pink" data-bs-toggle="tooltip" data-bs-placement="bottom">
            <i class="fas fa-map-marker-alt"></i>
                </a>
            </li>
            <li class="nav-item me-3">
                <c:if test="${not empty sessCustId}">
                    <div class="dropdown">
                    <button class="btn btn-outline-secondary dropdown-toggle" type="button" id="profileMenu" data-bs-toggle="dropdown">
                        <i class="fas fa-user"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" style="font-weight: bold;" href="javascript:updateFunc('${sessCustId}')">개인정보 수정</a></li>
                        <li><hr class="dropdown-divider"></hr></li>
                        <li><a class="dropdown-item text-danger" style="font-weight: bold;" href="#" data-bs-toggle="modal"
                        data-bs-target="#logoutModal">로그아웃</a></li>
                    </ul>
                </c:if>
            </li>
        </ul>
</nav>
<c:if test="${not empty sessCustId}">
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <h6>로그아웃할까요?</h6>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger" onclick="performLogout()">로그아웃</button>
                </div>
            </div>
        </div>
    </div>
</c:if>
<script>
    function performLogout() {
    
    window.location.href = "/project_H/user/logout";
    }
</script>