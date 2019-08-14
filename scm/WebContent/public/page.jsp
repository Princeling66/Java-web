<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="pageDiv">
	当前第<span id="currentPage">${page.currentPage}</span>页
	<c:if test="${page.currentPage == 1}">
		<input type="button" value="首页" disabled="disabled"/>
		<input type="button" value="上一页" disabled="disabled"/>
	</c:if>
	<c:if test="${page.currentPage != 1}">
		<input type="button" value="首页" onclick="goPage(1)"/>
		<input type="button" value="上一页" onclick="goPage(${page.currentPage-1})"/>
	</c:if>
	<c:if test="${page.currentPage == page.totalPage}">
		<input type="button" value="下一页" disabled="disabled"/>
		<input type="button" value="末页" disabled="disabled"/>
	</c:if>
	<c:if test="${page.currentPage != page.totalPage}">
		<input type="button" value="下一页" onclick="goPage(${page.currentPage+1})"/>
		<input type="button" value="末页" onclick="goPage(${page.totalPage})"/>
	</c:if>
	共${page.totalPage}页 ${page.totalSize }条记录
</div>