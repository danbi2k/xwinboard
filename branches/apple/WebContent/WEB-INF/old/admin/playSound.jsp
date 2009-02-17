<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<SCRIPT LANGUAGE="javascript">        

//MediaPlayer1은 본문에 삽입된 Object의 ID

var state=0;

function moteVol(player, val){ // 볼륨조절
	player.Volume = val;
}

function playIt(player){
  if ((navigator.userAgent.indexOf('IE') > -1) && (navigator.platform == "Win32")) {
	  player.Play();
  }
}
        
function pauseIt(player){
  if ((navigator.userAgent.indexOf('IE') > -1) && (navigator.platform == "Win32")) {
	  player.Pause();
  } 
}

function stopIt(player){
  if ((navigator.userAgent.indexOf('IE') > -1) && (navigator.platform == "Win32")) {
	  player.Stop();
	  player.CurrentPosition=0;  //미디어 플레이어의 플레이 위치를 초기화
  } 
}        
</SCRIPT>


<!-- Media Palyer의 삽입 //-->
<object id="player1" width="0" height="0" classid="CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95" standby="Loading Microsoft?Windows?Media Player components..." type="application/x-oleobject">
  <param name="transparentAtStart" value="True">
  <param name="transparentAtStop" value="True">
  <param name="AnimationAtStart" value="False">
  <param name="AutoStart" value="false">
  <param name="AutoRewind" value="true">
  <param name="DisplaySize" value="0">
  <param name="AutoSize" value="false">
  <param name="ShowDisplay" value="false">
  <param name="ShowStatusBar" value="false">
  <param name="ShowControls" value="false">
  <param name="EnableContextMenu" value="False">
  <param name="FileName" value="sound/1.wav">
  <param name="Volume" value="0">
  <embed type="application/x-mplayer2" pluginspage = "http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/" src="sound/1.wav" name="MediaPlayer1" width=480 height=360 displaysize=0 showcontrols=0 autostart=0>
  </embed> 
</object>

<object id="player2" width="0" height="0" classid="CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95" standby="Loading Microsoft?Windows?Media Player components..." type="application/x-oleobject">
  <param name="transparentAtStart" value="True">
  <param name="transparentAtStop" value="True">
  <param name="AnimationAtStart" value="False">
  <param name="AutoStart" value="false">
  <param name="AutoRewind" value="true">
  <param name="DisplaySize" value="0">
  <param name="AutoSize" value="false">
  <param name="ShowDisplay" value="false">
  <param name="ShowStatusBar" value="false">
  <param name="ShowControls" value="false">
  <param name="EnableContextMenu" value="False">
  <param name="FileName" value="sound/2.wav">
  <param name="Volume" value="0">
  <embed type="application/x-mplayer2" pluginspage = "http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/" src="sound/2.wav" name="MediaPlayer1" width=480 height=360 displaysize=0 showcontrols=0 autostart=0>
  </embed> 
</object>

<object id="player3" width="0" height="0" classid="CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95" standby="Loading Microsoft?Windows?Media Player components..." type="application/x-oleobject">
  <param name="transparentAtStart" value="True">
  <param name="transparentAtStop" value="True">
  <param name="AnimationAtStart" value="False">
  <param name="AutoStart" value="false">
  <param name="AutoRewind" value="true">
  <param name="DisplaySize" value="0">
  <param name="AutoSize" value="false">
  <param name="ShowDisplay" value="false">
  <param name="ShowStatusBar" value="false">
  <param name="ShowControls" value="false">
  <param name="EnableContextMenu" value="False">
  <param name="FileName" value="sound/3.wav">
  <param name="Volume" value="0">
  <embed type="application/x-mplayer2" pluginspage = "http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/" src="sound/3.wav" name="MediaPlayer1" width=480 height=360 displaysize=0 showcontrols=0 autostart=0>
  </embed> 
</object>

<object id="player4" width="0" height="0" classid="CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95" standby="Loading Microsoft?Windows?Media Player components..." type="application/x-oleobject">
  <param name="transparentAtStart" value="True">
  <param name="transparentAtStop" value="True">
  <param name="AnimationAtStart" value="False">
  <param name="AutoStart" value="false">
  <param name="AutoRewind" value="true">
  <param name="DisplaySize" value="0">
  <param name="AutoSize" value="false">
  <param name="ShowDisplay" value="false">
  <param name="ShowStatusBar" value="false">
  <param name="ShowControls" value="false">
  <param name="EnableContextMenu" value="False">
  <param name="FileName" value="sound/4.wav">
  <param name="Volume" value="0">
  <embed type="application/x-mplayer2" pluginspage = "http://www.microsoft.com/Windows/Downloads/Contents/Products/MediaPlayer/" src="sound/3.wav" name="MediaPlayer1" width=480 height=360 displaysize=0 showcontrols=0 autostart=0>
  </embed> 
</object>