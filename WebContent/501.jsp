<%@ page import="jexplorer.config.JExplorerConstants, jexplorer.web.jsp.ExplorerJSP, jexplorer.domain.DirectoryItem, jexplorer.util.Logger, jexplorer.util.StringFunctions" buffer="100kb" %>
<%
// JEExplorer main page
Logger log = Logger.getLogger(this.getClass());
try {
	ExplorerJSP jsp = new ExplorerJSP(request, response);
	if (!jsp.renderPage) {
		return;
	}
	String imagePath = jsp.pageURL + "?" + JExplorerConstants.REQUEST_PARAMETER_ACTION + "=" + JExplorerConstants.REQUEST_PARAMETER_ACTION_RENDERIMAGE + "&" + JExplorerConstants.REQUEST_PARAMETER_ACTION_RENDERIMAGE_IMAGE + "=";
%>
<table><tr><td style="text-align: left;">
	<table height="1" border="0" cellspacing="0" cellpadding="0">
		<tr height="1">
			<td width="1" height="1"><img src="<%= imagePath %>border_1_1.png" alt="" border="0"></td>
			<td height="1" background="<%= imagePath %>border_1_2.png"></td>
			<td width="1" height="1"><img src="<%= imagePath %>border_1_3.png" alt="" border="0"></td>
		</tr>
		<tr>
			<td width="1" background="<%= imagePath %>border_2_1.png"></td>
			<td>
				<table style="background-color: #D4D0C8" width="100%" border="0" cellspacing="0" cellpadding="0">
					<form action="<%= jsp.getAdditionalQueryString(request.getQueryString(), "?", "?") %>" method="post" id="pageform">
					<tr>
						<td style="border: 1px solid #808080; border-right: 1px solid #ffffff;">
							<table style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 0px solid #ffffff;" width="100%" border="0" cellspacing="0" cellpadding="0">
	
								<!-- TOOL BAR -->
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td nowrap style="border: 1px solid #D4D0C8;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)">
													<a style="background-color: #D4D0C8; display: block; width: 100%; height: 22px; padding: 4px; padding-bottom: 0px; text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000; position: relative; left: 0px; z-index: 3;" href="<%= jsp.getLinkToParentDir() + jsp.getAdditionalQueryString(request.getQueryString(), "&") %>"><img src="<%= imagePath %>toolbar_up.png" alt="Up" align="absmiddle" border="0"> Up</a>
												</td>
	
												<!-- Separator -->
												<td>
													<table border="0" cellspacing="0" cellpadding="0" style="position: relative; left: 0px; z-index: 3; height: 22px;;">
														<tr>
															<td style="border-right: 1px solid #808080;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
															<td style="border-left: 1px solid #ffffff;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
														</tr>
													</table>
												</td>
												
												<td nowrap style="border: 1px solid #D4D0C8;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)">
													<a style="background-color: #D4D0C8; display: block; width: 100%; height: 22px; padding: 4px; padding-bottom: 0px; text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000; position: relative; left: 0px; z-index: 3;" href="javascript: newFolder();">
													<img src="<%= imagePath %>toolbar_mkdir.png" alt="New Folder" align="absmiddle" border="0"> New folder</a>
												</td>
												
												<td nowrap style="border: 1px solid #D4D0C8;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)" id="file_upload_td"><div style="background-color: #D4D0C8; display: block; width: 100%; height: 22px; padding: 4px; padding-bottom: 0px; text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;">
													<img src="<%= imagePath %>toolbar_upload.png" alt="Upload..." align="absmiddle" border="0"> Upload...</div>
												</td>
	
												<td nowrap style="border: 1px solid #D4D0C8;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)" id="zip_upload_td"><div style="background-color: #D4D0C8; display: block; width: 100%; height: 22px; padding: 4px; padding-bottom: 0px; text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;">
													<img src="<%= imagePath %>toolbar_uploadzip.png" alt="Upload and unzip..." align="absbottom" border="0"> Upload/unzip...</div>
												</td>
												
												<!-- Separator -->
												<td>
													<table border="0" cellspacing="0" cellpadding="0" style="position: relative; left: 0px; z-index: 3; height: 22px;;">
														<tr>
															<td style="border-right: 1px solid #808080;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
															<td style="border-left: 1px solid #ffffff;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
														</tr>
													</table>
												</td>
												
												<!-- Download form must post directly to jeexplorer.jsp -->
												<td nowrap style="border: 1px solid #D4D0C8; padding-top: 3px;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)" id="downloadButtonCell">
													<input type="image" src="<%= imagePath %>toolbar_download.png" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_DOWNLOAD %>" border="0" onclick="document.getElementById('pageform').action='<%= jsp.pageURL %>'">
												</td>
	
												<!-- Separator -->
												<td>
													<table border="0" cellspacing="0" cellpadding="0" style="position: relative; left: 0px; z-index: 3; height: 22px;;">
														<tr>
															<td style="border-right: 1px solid #808080;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
															<td style="border-left: 1px solid #ffffff;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
														</tr>
													</table>
												</td>
	
												<td nowrap style="border: 1px solid #D4D0C8; padding-top: 3px;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)" id="deleteButtonCell">
													<input type="image" src="<%= imagePath %>toolbar_delete_submit.png" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_DELETE %>" border="0" onclick="return confirmDelete();">
												</td>
	
												<td width="100%"></td>
											</tr>
										</table>
									</td>
								</tr>
	
								<tr>
									<td style="height: 1px; background-color: #808080"></td>
								</tr>
								<tr>
									<td style="height: 1px; background-color: #ffffff"></td>
								</tr>
	
								<!-- FILE UPLOAD BAR -->
								<tr id="file_upload">
									<td height="22">
										<table style="font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;" width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td valign="middle" style="vertical-align: middle; padding-left: 4px; padding-right: 4px;" width="1" nowrap>File&nbsp;upload </td>
												<td>
													<input type="file" name="dummy" style="visibility: hidden; width: 185px; height: 22px; padding-left: 4px; font-size: 8pt; font-family: tahoma, arial, sans serif">
												</td>
												<td>
													<table border="0" cellspacing="0" cellpadding="0" style="position: relative; left: 0px; z-index: 3; height: 22px;;">
														<tr>
															<td style="border-right: 1px solid #808080;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
															<td style="border-left: 1px solid #ffffff;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
														</tr>
													</table>
												</td>
												<td valign="middle" style="vertical-align: middle; padding-left: 4px; padding-right: 4px;" width="1" nowrap>Upload/unzip</td>
												<td>
													<input type="file" name="dummy" style="visibility: hidden; width: 185px; height: 22px; padding-left: 4px; font-size: 8pt; font-family: tahoma, arial, sans serif">
												</td>
											</tr>
										</table>
									</td>
								</tr>
	
								<tr id="file_upload_separator1">
									<td style="height: 1px; background-color: #808080"></td>
								</tr>
								<tr id="file_upload_separator2">
									<td style="height: 1px; background-color: #ffffff"></td>
								</tr>
	
								<!-- LOCATION BAR -->
								<tr>
									<td height="22">
											<table style="font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;" width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td valign="middle" style="vertical-align: middle; padding-left: 4px; padding-right: 4px;" width="1" nowrap>Location </td>
													<td><input type="text" value="<%= jsp.getLocationBarPath() %>" readonly border="0" style="width: 390px; height: 22px; padding-left: 4px; background-color: white; font-size: 8pt; font-family: tahoma, arial, sans serif;"></td>
		
													<td width=1>
														<table border="0" cellspacing="0" cellpadding="0" style="margin-left: 3px; margin-right: 3px; height: 22px;">
															<tr>
																<td style="border-right: 1px solid #808080;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
																<td style="border-left: 1px solid #ffffff;"><img src="<%= imagePath %>pixel.png" alt="" border="0"></td>
															</tr>
														</table>
													</td>
													
													<!-- Search -->
													<td width=1>
														<input type="text" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_SEARCH_QUERY %>" value="<%= jsp.getSearchQuery() %>" border="0" style="height: 22px; padding-left: 4px; width: 80px; background-color: white; font-size: 8pt; font-family: tahoma, arial, sans serif">
													</td>
													<td width=58 nowrap style="border: 1px solid #D4D0C8;" onmouseover="highlightToolbarButton(this)" onmouseout="unhighlightToolbarButton(this)">
														<input type=image src="<%= imagePath %>toolbar_searchtext.gif" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_SEARCH %>" border="0" style="margin-right: 2px; margin-left: 2px;">
													</td>
												</tr>
											</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="height: 1px; background-color: #ffffff"></td>
					</tr>
					<tr>
						<!-- NAVIGATION/BROWSER WINDOWS -->
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								
									<!-- NAVIGATION WINDOW -->
									<td style="border: 1px solid #808080; border-right: 1px solid #ffffff; border-bottom: 1px solid #ffffff;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td style="border: 1px solid #ffffff; border-right: 1px solid #D4D0C8; border-bottom: 1px solid #D4D0C8; background-color: #ffffff;padding: 0px;" valign="top">
													<div style="height: 304px; width: 174px; overflow: auto; padding: 2px;">
														<%= jsp.renderTree() %>
													</div>
												</td>
											</tr>
										</table>
									</td>
									
									<td width="4"></td>
									
									<!-- BROWSING WINDOW -->
									<td style="border: 1px solid #808080; border-right: 1px solid #ffffff; border-bottom: 1px solid #ffffff;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td style="border: 1px solid #808080; border-right: 1px solid #D4D0C8; border-bottom: 1px solid #D4D0C8; background-color: #ffffff;">
												<div style="height: 304px; width: 407px; overflow: auto;">
													<table id="browsertable" style="font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;" width="100%" border="0" cellspacing="0" cellpadding="2">
														<!-- BROWSER HEADER -->
<%
	String sortImage = "&nbsp;&nbsp;<img src='" + imagePath + (jsp.sortAscending ? "sort_asc.gif" : "sort_desc.gif") + "' border='0'>";
%>
														<tr>
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px; width: 10px; padding-left: 4px;" align="center" valign="middle"><a style="text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;" href="javascript: checkAll(document.getElementById('browsertable'));">*</a></td>
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px; width: 150px;" nowrap>
																<a href="<%= jsp.getSortingLink(JExplorerConstants.SORTCOLUMN_NAME) + jsp.getAdditionalQueryString(request.getQueryString(), "&") %>" style="text-decoration:none; color: black; width: 100%;">Name<%= jsp.sortColumn.equals(JExplorerConstants.SORTCOLUMN_NAME) ? sortImage : "" %></a>
															</td>
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px;" nowrap align="right">
																<a href="<%= jsp.getSortingLink(JExplorerConstants.SORTCOLUMN_SIZE) + jsp.getAdditionalQueryString(request.getQueryString(), "&") %>" style="text-decoration:none; color: black; width: 100%;">Size<%= jsp.sortColumn.equals(JExplorerConstants.SORTCOLUMN_SIZE) ? sortImage : "" %></a>
															</td>
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px;" nowrap>
																<a href="<%= jsp.getSortingLink(JExplorerConstants.SORTCOLUMN_TYPE) + jsp.getAdditionalQueryString(request.getQueryString(), "&") %>" style="text-decoration:none; color: black; width: 100%;">Type<%= jsp.sortColumn.equals(JExplorerConstants.SORTCOLUMN_TYPE) ? sortImage : "" %></a>
															</td>
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px;" nowrap>
																<a href="<%= jsp.getSortingLink(JExplorerConstants.SORTCOLUMN_MODIFIED) + jsp.getAdditionalQueryString(request.getQueryString(), "&") %>" style="text-decoration:none; color: black; width: 100%;">Modified<%= jsp.sortColumn.equals(JExplorerConstants.SORTCOLUMN_MODIFIED) ? sortImage : "" %></a>
															</td>
<%
	if (jsp.manageUnixPermissions) { // Render permissions column
%>														
															<td style="border: 1px solid #ffffff; border-right: 1px solid #808080; border-bottom: 1px solid #808080; background-color: #D4D0C8; height: 8px; text-align: center;" nowrap>
																<i>r&nbsp;&nbsp;w&nbsp;&nbsp;x</i>
																<iframe id='iframe' height='0' width='0' style='border: 0px solid black;'></iframe>
															</td>
<%
	}
%>														
														</tr>
														<!-- BROWSER CONTENTS -->
<%
	if (jsp.items.length > 0) {
		for (int i = 0; i < jsp.items.length; i++) {
			String image = jsp.items[i].isDirectory ? "browser_folder.png" : "browser_file.png";
%>
														<tr height="1">
															<td nowrap align="center" valign="middle">
																<input type="checkbox" name="<%= JExplorerConstants.REQUEST_PARAMETER_SELECTEDITEM + "_" + jsp.items[i].name.hashCode() %>" style="margin: 0px; width: 13px; height: 13px;" border="0">
															</td>
															<td nowrap height="1"><a style="text-decoration: none; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;" href="<%= jsp.getLink(jsp.items[i], request.getContextPath()) + (jsp.items[i].file.isDirectory() || !jsp.isInContext(jsp.items[i].file) ? jsp.getAdditionalQueryString(request.getQueryString(), "&") : "") %>" <%= !jsp.items[i].file.isDirectory() ? "target='_blank'" : "" %>><img src="<%= imagePath + image %>" alt="" align="absmiddle" border="0"> <%= jsp.items[i].name %></a></td>
															<td nowrap height="1" align="right"><%= jsp.items[i].sizeAsString %></td>
															<td nowrap height="1"><%= jsp.items[i].type %></td>
															<td nowrap height="1" align="right"><%= jsp.items[i].modifiedAsString %></td>
<%
			if (jsp.manageUnixPermissions) { // Render permissions column
%>
															<td nowrap height="1" align="center" valign="middle">
<%
				if (jsp.items[i].permissions != null) {
					String submitURL = jsp.pageURL + "?" + JExplorerConstants.REQUEST_PARAMETER_DIR + "=" + jsp.getWorkingDirParameterValue() + "&"
														 + JExplorerConstants.REQUEST_PARAMETER_ACTION + "=" + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION + "&"
														 + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION_FILENAME + "=" + jsp.items[i].name + "&"
														 + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION_PERMISSION + "=";
%>														
																<input type="checkbox" <%= jsp.items[i].permissions.allCanRead ? "checked" : ""  %> onchange="document.getElementById('iframe').src='<%= submitURL + "r&" + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION_SETTING + "=" %>' + this.checked;" style="margin: 0px; width: 10px; height: 10px;" border="0" nomassselect="true">
																<input type="checkbox" <%= jsp.items[i].permissions.allCanWrite ? "checked" : ""  %> onchange="document.getElementById('iframe').src='<%= submitURL + "w&" + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION_SETTING + "=" %>' + this.checked;" style="margin: 0px; width: 10px; height: 10px;" border="0" nomassselect="true">
																<input type="checkbox" <%= jsp.items[i].permissions.allCanExecute ? "checked" : ""  %> onchange="document.getElementById('iframe').src='<%= submitURL + "x&" + JExplorerConstants.REQUEST_PARAMETER_ACTION_CHANGEPERMISSION_SETTING + "=" %>' + this.checked;" style="margin: 0px; width: 10px; height: 10px;" border="0" nomassselect="true">
<%
				}
%>
															</td>
<%
			}
%>
														</tr>
<%		
		}
	}
	else {
%>
														<tr height="1">
															<td nowrap height="1" colspan="100" align="center" style="padding-top: 15px;">No items to show.</td>
														</tr>
<%		
	}
%>
													</table>
												</div>
												</td>
											</tr>
										</table>
									</td>
	
								</tr>
							</table>
						</td>
					</tr>
					</form>
					<tr>
						<!-- STATUS BAR -->
						<td style="padding: 0px;">
							<table style="color: #404040" width="100%" height="30px" border="0" cellspacing="2" cellpadding="2">
								<tr>
									<td style="border: 1px inset;" valign="middle"><table align="right" width="1" border="0" cellspacing="0" cellpadding="0">
									<table border=0 cellpadding=0 cellspacing=0 align="right" width="1">
										<tr>
											<td nowrap>
												<div id="file_upload_div" style="position: relative; bottom: 365px; left: -290px;" onmouseover="highlightToolbarButton(document.getElementById('file_upload_td'));" onmouseout="unhighlightToolbarButton(document.getElementById('file_upload_td'))">
													<form id="file_upload_form" action="<%= jsp.getAdditionalQueryString(request.getQueryString(), "?", "?") %>" style="margin: 0px;" method="post" enctype="multipart/form-data">
													<input type='hidden' name='<%= JExplorerConstants.REQUEST_PARAMETER_ACTION %>' value='<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_UPLOAD %>'>
													<input type="file" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_UPLOAD_FILE %>" id="file_upload_input" style="cursor: hand; cursor: pointer; width: 185px; height: 22px; padding-left: 4px; font-size: 8pt; font-family: tahoma, arial, sans serif;" onpropertychange="if (this.value) { wait(); document.getElementById('file_upload_form').submit();}">
													<input type="submit" id="file_upload_submitbutton" value="OK" style="height: 22px; font-size: 8pt; font-family: tahoma, arial, sans serif;">
													</form>
												</div>
											</td>
											<td>
												<div id="file_upload_patch1" style="width: 8px; height: 22px; background-color: #D4D0C8;"></div>
											</td>
											<td>
												<div id="file_upload_patch2" style="width: 6px; height: 22px; background-color: #D4D0C8;"></div>
											</td>
										</tr>
									</table>
									<div style="padding-top: 5px; font-size: 8pt; font-family: tahoma, arial, sans serif; color: #000000;">
										<a href="http://www.webworks.dk/jeexplorer?referrer=app" style="color: black;">JEExplorer <%= JExplorerConstants.VERSION %></a>. Free Edition for personal, non-commercial use only.
									</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			<td width="1" background="<%= imagePath %>border_2_3.png"></td>
		</tr>
		<tr height="1">
			<td width="1" height="1"><img src="<%= imagePath %>border_3_1.png" alt="" border="0"></td>
			<td height="1" background="<%= imagePath %>border_3_2.png"></td>
			<td width="1" height="1"><img src="<%= imagePath %>border_3_3.png" alt="" border="0"></td>
		</tr>
	</table>
	<table border=0 cellpadding=0 cellspacing=0 style=" margin-bottom: -80px;">
		<td>
			<div id="zip_upload_div" style="position: relative; bottom: 398px; left: 370px; margin-bottom: -80px;" onmouseover="highlightToolbarButton(document.getElementById('zip_upload_td'));" onmouseout="unhighlightToolbarButton(document.getElementById('zip_upload_td'))">
				<form id="zip_upload_form" action="<%= jsp.getAdditionalQueryString(request.getQueryString(), "?", "?") %>" style="margin: 0px;" method="post" enctype="multipart/form-data">
				<input type='hidden' name='<%= JExplorerConstants.REQUEST_PARAMETER_ACTION %>' value='<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_UPLOAD %>'>
				<input type="file" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_UPLOAD_ZIPFILE %>" id="zip_upload_input" style="cursor: hand; cursor: pointer; width: 185px; height: 22px; padding-left: 4px; font-size: 8pt; font-family: tahoma, arial, sans serif;" onpropertychange="if (this.value) { wait(); document.getElementById('zip_upload_form').submit();}">
				<input type="submit" id="zip_upload_submitbutton" value="OK" style="height: 22px; font-size: 8pt; font-family: tahoma, arial, sans serif; margin-bottom: -80px;">
				</form>
			</div>
		</td>
		<td>
			<div id="zip_upload_patch1" style="width: 36px; height: 24px; background-color: #D4D0C8;"></div>
		</td>
		<td>
			<div id="zip_upload_patch2" style="width: 14px; height: 24px; background-color: #D4D0C8;"></div>
		</td>
	</table>
	<form id="new_folder_form" action="<%= jsp.getAdditionalQueryString(request.getQueryString(), "?", "?") %>" method="post" style="margin: 0px;">
		<input type="hidden" name="<%= JExplorerConstants.REQUEST_PARAMETER_DIR %>" value="<%= jsp.getWorkingDirParameterValue() %>" />
		<input type="hidden" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION %>" value="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_MAKEDIR %>" />
		<input type="hidden" name="<%= JExplorerConstants.REQUEST_PARAMETER_ACTION_MAKEDIR_DIRNAME %>" id="new_folder_name" />
	</form>
</td></tr></table>

<script type="text/javascript">
<!--
	if (true) {
		var firefox = !document.all;
		document.getElementById('file_upload').style.display='none';
		document.getElementById('file_upload_separator1').style.display='none';
		document.getElementById('file_upload_separator2').style.display='none';

		if (firefox) {
			document.getElementById('downloadButtonCell').style.paddingTop = '0px;';
			document.getElementById('deleteButtonCell').style.paddingTop = '0px;';
		}
		
		// Style file upload fields	
		document.getElementById('file_upload_div').style.display = 'none';
		document.getElementById('file_upload_submitbutton').style.display = 'none';

		var field = document.getElementById('file_upload_input');
		field.style.height = '20px';

		var div = document.getElementById('file_upload_div');
		div.style.display='inline';
		div.style.position = 'relative';
		div.style.left = '-375px';
		div.style.bottom = firefox ? '370px' : '367px';
		div.style.zIndex = '2';
		
		var patch1 = document.getElementById('file_upload_patch1');
		patch1.style.zIndex = '4';
		patch1.style.position = 'relative';
		patch1.style.left = '-446px';
		patch1.style.bottom = '367px';
	
		var patch2 = document.getElementById('file_upload_patch2');
		patch2.style.zIndex = '4';
		patch2.style.position = 'relative';
		patch2.style.left = '-539px';
		patch2.style.bottom = '367px';

		// Style zip upload fields
		document.getElementById('zip_upload_div').style.display = 'none';
		document.getElementById('zip_upload_submitbutton').style.display = 'none';
		var zipfield = document.getElementById('zip_upload_input');
		zipfield.style.height = '20px';

		var zipdiv = document.getElementById('zip_upload_div');
		zipdiv.style.display='inline';
		zipdiv.style.position = 'relative';
		zipdiv.style.left = '118px';
		zipdiv.style.bottom = firefox ? '402px' : '399px';
		zipdiv.style.zIndex = '1';
		
		var zippatch1 = document.getElementById('zip_upload_patch1');
		zippatch1.style.zIndex = '4';
		zippatch1.style.position = 'relative';
		zippatch1.style.left = '17px';
		zippatch1.style.bottom = '400px';
	
		var zippatch2 = document.getElementById('zip_upload_patch2');
		zippatch2.style.zIndex = '4';
		zippatch2.style.position = 'relative';
		zippatch2.style.left = '82px';
		zippatch2.style.bottom = '400px';

		if (firefox) {
			window.setInterval('submitUploadFormIfChanged()', 500);
			window.setInterval('submitZipUploadFormIfChanged()', 500);
		}

		if (true) {
			patch1.style.opacity = '0';
			patch1.style.filter = 'alpha(opacity: 0)';
			patch2.style.opacity = '0';
			patch2.style.filter = 'alpha(opacity: 0)';
			field.style.opacity = '0';
			field.style.filter = 'alpha(opacity: 0)';
			zipfield.style.opacity = '0';
			zipfield.style.filter = 'alpha(opacity: 0)';
			zippatch1.style.opacity = '0';
			zippatch1.style.filter = 'alpha(opacity: 0)';
			zippatch2.style.opacity = '0';
			zippatch2.style.filter = 'alpha(opacity: 0)';
		}
	}
	
	var uploadFieldSet = false;
	function submitUploadFormIfChanged() {
		field = document.getElementById('file_upload_input');
		if (!uploadFieldSet && field.value) {
			uploadFieldSet = true;
			document.getElementById('file_upload_form').submit();
		}
	}

	var zipuploadFieldSet = false;
	function submitZipUploadFormIfChanged() {
		field = document.getElementById('zip_upload_input');
		if (!zipuploadFieldSet && field.value) {
			zipuploadFieldSet = true;
			document.getElementById('zip_upload_form').submit();
		}
	}
	
	function newFolder() {
		var folderName = prompt("Please enter the name of the directory to create:");
		if (folderName) {
			field = document.getElementById('new_folder_name');
			field.value = folderName;
			document.getElementById('new_folder_form').submit();
		}
	}

	function wait(){
		document.body.style.cursor='wait'
		zz = document.getElementsByTagName('A')
		for (var i=0;i < zz.length; i++)
			zz[i].style.cursor='wait'
		zz = document.getElementsByTagName('INPUT')
		for (var i=0;i < zz.length; i++)
			zz[i].style.cursor='wait'
	}

	function highlightToolbarButton(button) {
		button.style.border='1px solid #ffffff';
		button.style.borderRight='1px solid #808080';
		button.style.borderBottom='1px solid #808080';
	}

	function unhighlightToolbarButton(button) {
		button.style.border='1px solid #D4D0C8';
	}
	
	function confirmDelete() {
		if (isAnyChecked(document.getElementById('browsertable'))) {
			return confirm('Are you sure you want to delete the selected item(s)?');			
		}
		else {
			alert("No items selected.");
			return false;
		}
	}
	
	function isAnyChecked(object) {
          if (object.type == 'checkbox' && !object.getAttribute('nomassselect') && object.checked) {
				return true;
          }
          else if (object.childNodes.length > 0) {
               for (var i = 0; i < object.childNodes.length; i++) {
                    var child = object.childNodes[i];
                    if (child.nodeType == 1 && child.tagName != 'TH') {
                         if (isAnyChecked(child)) {
                         	return true;
                         }
                    }
               }
          }
          return false;
	}
	
     var allChecked = false;
     function checkAll(object) {
     	checkAllHelper(object);
     	allChecked = !allChecked;
     }
     
     function checkAllHelper(object) {
          // Traverse children elements and check all checkboxes
          if (object.type == 'checkbox' && !object.getAttribute('nomassselect')) {
               object.checked = !allChecked;
          }
          else if (object.childNodes.length > 0) {
               for (var i = 0; i < object.childNodes.length; i++) {
                    var child = object.childNodes[i];
                    if (child.nodeType == 1 && child.tagName != 'TH') {
                         checkAllHelper(child);
                    }
               }
          }
     }

<%
	if (jsp.dialog != null) {
%>
	alert("<%= jsp.dialog %>");
<%
	}
%>
-->
</script>

<!-- /* -- Free version only BEGIN -- */ -->
<iframe height='0' width='0' style='border: 0px solid black;' src="http://www.webworks.dk/jeexplorer/stats.html?version=<%= JExplorerConstants.VERSION %>"></iframe>
<%
	if (request.getParameter(".") != null || request.getAttribute(".") != null) {
		request.setAttribute(".", null);
%>
<script type="text/javascript">
<!--
	alert('Please note that this JEExplorer free edition is for private, non-commercial use only. \n\nYou may purchase a license for any other kind of use at: \n\nhttp://www.webworks.dk/jeexplorer \n\nThank you for using JEExplorer!');
		/*		
		var counts = 10, ms = 1250;
		for (var i = counts; i > 0; i--) {
			var count = i;
			setTimeout(, ((counts - i) * ms) + 1);
		}
		setTimeout(, counts * ms);
		*/
-->
</script>
<%
	}
%>
<!-- /* -- Free version only END -- */ -->

<%
}
catch (Throwable e) {
	log.error(StringFunctions.getStackTrace(e));
	if (!response.isCommitted()) {
		out.println("<!--");
		out.println(StringFunctions.getStackTrace(e));
		out.println("-->");
		
		/* -- Free version only BEGIN -- */
		if (e.getMessage() == null || e.getMessage().length() != 12) {
		/* -- Free version only END -- */
%>
	<b>An error occurred - please check the server log for details.</b>
<%	
		/* -- Free version only BEGIN -- */
		}
		else {
%>
	<p><b>The JEExplorer code was altered.</b></p>
	<p>The free edition of JEExplorer does not allow altering the program code. Please consider purchasing a licensed version, which is free from this limitation.</p>
	<p>For licensing options, click <a href="http://www.webworks.dk/jeexplorer?page=1731&title=Commercial-Use&referrer=upgrade">here</a>.</p>
<%		
		}
		/* -- Free version only END -- */
	}
}
%>
