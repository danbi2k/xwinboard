package com.xwin.domain.board;

import java.util.Date;
import java.util.List;

import com.xwin.domain.XwinObject;

public class BoardItem extends XwinObject
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3341431255378033828L;
	
	private String id;
	private String title;
	private String userId;
	private String nickName;
	private Date date;
	private Integer readCount;
	private String context;
	private String type;
	private String status;
	private String boardName;
	private Integer commentCount;
	private String isDeleted;
	private String isChecked;
	private String grade;
	private String bettingId;
	
	private List<BoardComment> boardCommentList;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Integer getReadCount() {
		return readCount;
	}
	public void setReadCount(Integer readCount) {
		this.readCount = readCount;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public List<BoardComment> getBoardCommentList() {
		return boardCommentList;
	}
	public void setBoardCommentList(List<BoardComment> boardCommentList) {
		this.boardCommentList = boardCommentList;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public Integer getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(Integer commentCount) {
		this.commentCount = commentCount;
	}
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String isDeleted) {
		this.isDeleted = isDeleted;
	}
	public String getIsChecked() {
		return isChecked;
	}
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getBettingId() {
		return bettingId;
	}
	public void setBettingId(String bettingId) {
		this.bettingId = bettingId;
	}	
}
