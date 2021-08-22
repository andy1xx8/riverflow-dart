import 'dart:convert';

import 'package:riverflow/riverflow.dart';
import 'package:test/test.dart';

void main() {
  test('Parse HTML Form should OK', () {

    final html = r'''
    <form action="https://www.hoasentrenda.com/smf/index.php?action=post2;start=0;board=12" method="post" accept-charset="UTF-8" name="postmodify" id="postmodify" onsubmit="submitonce(this);saveEntities();" enctype="multipart/form-data" style="margin: 0;">
			<table width="100%" align="center" cellpadding="0" cellspacing="3">
				<tbody><tr>
					<td valign="bottom" colspan="2">
						<div class="nav_link_tree"><b><span class="linktree_post"><a href="https://www.hoasentrenda.com/smf/index.php" class="nav">Hoa Sen Trên Đá</a></span></b>&nbsp;►&nbsp;<b><span class="linktree_post"><a href="https://www.hoasentrenda.com/smf/index.php#1" class="nav">Đàm Luận Phật Pháp</a></span></b>&nbsp;►&nbsp;<b><span class="linktree_post"><a href="https://www.hoasentrenda.com/smf/index.php?board=12.0" class="nav">Tịnh Độ</a></span></b>&nbsp;►&nbsp;<b><i>Chủ đề mới</i></b></div>
					</td>
				</tr>
			</tbody></table>
		<div id="preview_section" style="display: none;">
			<table border="0" width="100%" cellspacing="1" cellpadding="3" class="bordercolor" align="center" style="table-layout: fixed;">
				<tbody><tr class="titlebg">
					<td id="preview_subject"></td>
				</tr>
				<tr>
					<td class="post" width="100%" id="preview_body">
						<br><br><br><br><br>
					</td>
				</tr>
			</tbody></table><br>
		</div>
			<table border="0" width="100%" align="center" cellspacing="1" cellpadding="3" class="bordercolor">
				<tbody><tr class="titlebg">
					<td>Chủ đề mới</td>
				</tr>
				<tr>
					<td class="windowbg">
						<input type="hidden" name="topic" value="0">
						<table border="0" cellpadding="3" width="100%">
							<tbody><tr style="display: none" id="errors">
								<td></td>
								<td align="left">
									<div style="padding: 0px; font-weight: bold; display: none;" id="error_serious">
										Các lỗi khi gửi bài viết này:
									</div>
									<div style="color: red; margin: 1ex 0 2ex 3ex;" id="error_list">
										
									</div>
								</td>
							</tr>
							<tr style="display: none" id="lock_warning">
								<td></td>
								<td align="left">
									Warning: chủ đề đang bị khóa!<br>Chỉ ban quản trị mới có thể trả lời.
								</td>
							</tr>
							<tr>
								<td class="mobile_hide" align="right" style="font-weight: bold;" id="caption_subject">
									Tiêu đề:
								</td>
								<td colspan="2">
									<input class="subject-post-input" type="text" name="subject" tabindex="1" maxlength="80">
								</td>
							</tr>
							<tr>
								<td align="right" class="mobile_hide">
									<b>Icon bài viết:</b>
								</td>
								<td colspan="2">
									<select name="icon" id="icon" onchange="showimage()">
										<option value="xx" selected="unselected">Standard</option>
										<option value="thumbup" selected="selected">Thumb Up</option>
										<option value="thumbdown">Thumb Down</option>
										<option value="exclamation">Exclamation point</option>
										<option value="question">Question mark</option>
										<option value="lamp">Lamp</option>
										<option value="smiley">Smiley</option>
										<option value="angry">Angry</option>
										<option value="cheesy">Cheesy</option>
										<option value="grin">Grin</option>
										<option value="sad">Sad</option>
										<option value="wink">Wink</option>
									</select>
									<img src="https://www.hoasentrenda.com/smf/Themes/R70/images/post/xx.gif" name="icons" hspace="15" alt="">
								</td>
							</tr>
			<tr>
				<td align="right"></td>
				<td valign="middle">
					<script language="JavaScript" type="text/javascript"><!-- // --><![CDATA[
						function bbc_highlight(something, mode)
						{
							something.style.backgroundImage = "url(" + smf_images_url + (mode ? "/bbc/bbc_hoverbg.gif)" : "/bbc/bbc_bg.gif)");
						}
					// ]]></script><a href="javascript:void(0);" onclick="surroundText('[b]', '[/b]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bold.gif" align="bottom" width="23" height="22" alt="Đậm" title="Đậm" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[i]', '[/i]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/italicize.gif" align="bottom" width="23" height="22" alt="Nghiêng" title="Nghiêng" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[u]', '[/u]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/underline.gif" align="bottom" width="23" height="22" alt="Gạch dưới" title="Gạch dưới" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[s]', '[/s]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/strike.gif" align="bottom" width="23" height="22" alt="Strikethrough" title="Strikethrough" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[glow=red,2,300]', '[/glow]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/glow.gif" align="bottom" width="23" height="22" alt="Glow" title="Glow" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[shadow=red,left]', '[/shadow]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/shadow.gif" align="bottom" width="23" height="22" alt="Shadow" title="Shadow" style="background-image: url(&quot;https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif&quot;); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[move]', '[/move]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/move.gif" align="bottom" width="23" height="22" alt="Marquee" title="Marquee" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[pre]', '[/pre]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/pre.gif" align="bottom" width="23" height="22" alt="Preformatted Text" title="Preformatted Text" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[left]', '[/left]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/left.gif" align="bottom" width="23" height="22" alt="Căn trái" title="Căn trái" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[center]', '[/center]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/center.gif" align="bottom" width="23" height="22" alt="Căn giữa" title="Căn giữa" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[right]', '[/right]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/right.gif" align="bottom" width="23" height="22" alt="Căn phải" title="Căn phải" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="replaceText('[hr]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/hr.gif" align="bottom" width="23" height="22" alt="Đường kẻ ngang" title="Đường kẻ ngang" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[size=10pt]', '[/size]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/size.gif" align="bottom" width="23" height="22" alt="Kích thước Font" title="Kích thước Font" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[font=Verdana]', '[/font]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/face.gif" align="bottom" width="23" height="22" alt="Font" title="Font" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a> <select onchange="surroundText('[color=' + this.options[this.selectedIndex].value.toLowerCase() + ']', '[/color]', document.forms.postmodify.message); this.selectedIndex = 0; document.forms.postmodify.message.focus(document.forms.postmodify.message.caretPos);" style="margin-bottom: 1ex;">
							<option value="" selected="selected">Đổi màu sắc</option>
							<option value="Black">Đen</option>
							<option value="Red">Đỏ</option>
							<option value="Yellow">Vàng</option>
							<option value="Pink">Hồng</option>
							<option value="Green">Xanh lá</option>
							<option value="Orange">Cam</option>
							<option value="Purple">Tím</option>
							<option value="Blue">Xanh nước biển</option>
							<option value="Beige">Màu nâu nhạt</option>
							<option value="Brown">Nâu</option>
							<option value="Teal">Xanh mòng két</option>
							<option value="Navy">Xanh tím than</option>
							<option value="Maroon">Màu hạt dẻ</option>
							<option value="LimeGreen">Xanh dạ quang</option>
						</select><br><a href="javascript:void(0);" onclick="surroundText('[flash=200,200]', '[/flash]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/flash.gif" align="bottom" width="23" height="22" alt="Chèn Flash" title="Chèn Flash" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[img]', '[/img]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/img.gif" align="bottom" width="23" height="22" alt="Chèn hình ảnh" title="Chèn hình ảnh" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[url]', '[/url]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/url.gif" align="bottom" width="23" height="22" alt="Chèn liên kết" title="Chèn liên kết" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[email]', '[/email]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/email.gif" align="bottom" width="23" height="22" alt="Chèn email" title="Chèn email" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[ftp]', '[/ftp]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/ftp.gif" align="bottom" width="23" height="22" alt="Chèn liên kết FTP" title="Chèn liên kết FTP" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[table]', '[/table]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/table.gif" align="bottom" width="23" height="22" alt="Chèn bảng" title="Chèn bảng" style="background-image: url(&quot;https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif&quot;); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[tr]', '[/tr]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/tr.gif" align="bottom" width="23" height="22" alt="Chèn hàng" title="Chèn hàng" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[td]', '[/td]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/td.gif" align="bottom" width="23" height="22" alt="Chèn cột" title="Chèn cột" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[sup]', '[/sup]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/sup.gif" align="bottom" width="23" height="22" alt="Superscript" title="Superscript" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[sub]', '[/sub]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/sub.gif" align="bottom" width="23" height="22" alt="Subscript" title="Subscript" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[tt]', '[/tt]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/tele.gif" align="bottom" width="23" height="22" alt="Teletype" title="Teletype" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[code]', '[/code]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/code.gif" align="bottom" width="23" height="22" alt="Chèn mã" title="Chèn mã" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><a href="javascript:void(0);" onclick="surroundText('[quote]', '[/quote]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/quote.gif" align="bottom" width="23" height="22" alt="Chèn trích dẫn" title="Chèn trích dẫn" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/divider.gif" alt="|" style="margin: 0 3px 0 3px;"><a href="javascript:void(0);" onclick="surroundText('[list]\n[li]', '[/li]\n[li][/li]\n[/list]', document.forms.postmodify.message); return false;"><img onmouseover="bbc_highlight(this, true);" onmouseout="if (window.bbc_highlight) bbc_highlight(this, false);" src="https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/list.gif" align="bottom" width="23" height="22" alt="Tạo danh sách" title="Tạo danh sách" style="background-image: url(https://www.hoasentrenda.com/smf/Themes/R70/images/bbc/bbc_bg.gif); margin: 1px 2px 1px 1px;"></a>
				</td>
			</tr>
			<tr>
				<td align="right"></td>
				<td valign="middle">
					<a href="javascript:void(0);" onclick="replaceText(' :)', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/smiley.gif" align="bottom" alt="Smiley" title="Smiley"></a>
					<a href="javascript:void(0);" onclick="replaceText(' ;)', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/wink.gif" align="bottom" alt="Wink" title="Wink"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :D', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/cheesy.gif" align="bottom" alt="Cheesy" title="Cheesy"></a>
					<a href="javascript:void(0);" onclick="replaceText(' ;D', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/grin.gif" align="bottom" alt="Grin" title="Grin"></a>
					<a href="javascript:void(0);" onclick="replaceText(' >:(', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/angry.gif" align="bottom" alt="Angry" title="Angry"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :(', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/sad.gif" align="bottom" alt="Sad" title="Sad"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :o', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/shocked.gif" align="bottom" alt="Shocked" title="Shocked"></a>
					<a href="javascript:void(0);" onclick="replaceText(' 8)', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/cool.gif" align="bottom" alt="Cool" title="Cool"></a>
					<a href="javascript:void(0);" onclick="replaceText(' ???', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/huh.gif" align="bottom" alt="Huh" title="Huh"></a>
					<a href="javascript:void(0);" onclick="replaceText(' ::)', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/rolleyes.gif" align="bottom" alt="Roll Eyes" title="Roll Eyes"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :P', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/tongue.gif" align="bottom" alt="Tongue" title="Tongue"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :-[', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/embarrassed.gif" align="bottom" alt="Embarrassed" title="Embarrassed"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :-X', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/lipsrsealed.gif" align="bottom" alt="Lips sealed" title="Lips sealed"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :-\\', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/undecided.gif" align="bottom" alt="Undecided" title="Undecided"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :-*', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/kiss.gif" align="bottom" alt="Kiss" title="Kiss"></a>
					<a href="javascript:void(0);" onclick="replaceText(' :\'(', document.forms.postmodify.message); return false;"><img src="https://www.hoasentrenda.com/smf/Smileys/default/cry.gif" align="bottom" alt="Cry" title="Cry"></a>
				</td>
			</tr>
			<tr>
				<td class="mobile_hide_td" valign="top" align="right"></td>
				<td colspan="2">
					<textarea class="editor" name="message" rows="12" cols="60" onselect="storeCaret(this);" onclick="storeCaret(this);" onkeyup="storeCaret(this);" onchange="storeCaret(this);" tabindex="2"></textarea>
				</td>
			</tr>
									<tr>
										<td colspan="2" style="padding-left: 5ex;">
											<a href="javascript:swapOptions();"><img src="https://www.hoasentrenda.com/smf/Themes/R70/images/expand.gif" alt="+" id="postMoreExpand"></a> <a href="javascript:swapOptions();"><b>Các tùy chọn khác...</b></a>
										</td>
									</tr>
									<tr>
										<td></td>
										<td>
											<div id="postMoreOptions" style="display: none;">
												<table width="80%" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="smalltext"><input type="hidden" name="notify" value="0"><label for="check_notify"><input type="checkbox" name="notify" id="check_notify" value="1" class="check"> Thông báo khi có trả lời.</label></td>
														<td class="smalltext"></td>
													</tr>
													<tr>
														<td class="smalltext"><label for="check_back"><input type="checkbox" name="goback" id="check_back" value="1" class="check"> Trở lại chủ đề.</label></td>
														<td class="smalltext"></td>
													</tr>
													<tr>
														<td class="smalltext"><label for="check_smileys"><input type="checkbox" name="ns" id="check_smileys" value="NS" class="check"> Don't use smileys.</label></td>
														<td class="smalltext"></td>
													</tr>
												</tbody></table>
											</div>
										</td>
									</tr>
							<tr id="postAttachment2" style="display: none;">
								<td align="right" valign="top">
									<b>Gửi kèm:</b>
								</td>
								<td class="smalltext">
									<input type="file" size="48" name="attachment[]">
									<script language="JavaScript" type="text/javascript"><!-- // --><![CDATA[
										var allowed_attachments = 12 - 1;

										function addAttachment()
										{
											if (allowed_attachments <= 0)
												return alert("Bạn không được gửi thêm file nữa.");

											setOuterHTML(document.getElementById("moreAttachments"), '<br /><input type="file" size="48" name="attachment[]" /><span id="moreAttachments"></span>');
											allowed_attachments = allowed_attachments - 1;

											return true;
										}
									// ]]></script>
									<span id="moreAttachments"></span> <a href="javascript:addAttachment(); void(0);">(thêm file khác)</a><br>
									<noscript><input type="file" size="48" name="attachment[]" /><br /></noscript>
									Kiểu file cho phép: JPG, doc, gif, jpg, jpge, JPGE, mpg, pdf, png, txt, zip, mp3, wma, wmv, docx, xls, xlsx, ppt, pptx, m4a, mp4, aac, png, PNG, jpeg, JPEG<br>
									Kích thước tối đa: 100000 KB, số file tối đa: 12
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2">
									<span class="smalltext"><br>phím tắt: nhấn alt+s để gửi hoặc alt+p để xem trước</span><br>
									<input type="submit" name="post" value="Gửi bài" tabindex="3" onclick="return submitThisOnce(this);" accesskey="s">
									<input type="submit" name="preview" value="Xem trước" tabindex="4" onclick="return event.ctrlKey || previewPost();" accesskey="p">
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
						</tbody></table>
					</td>
				</tr>
			</tbody></table>
			<input type="hidden" name="additional_options" value="0">
			<input type="hidden" name="sc" value="6b81e29e3d422020c45cd7ff90166fa3">
			<input type="hidden" name="seqnum" value="5990658">
		</form>
    ''';

    final formElement = html.asDocument('https://www.hoasentrenda.com').body;

    final form = HtmlUtils.parseForm(formElement);

    print(jsonEncode(form));
    print('Completed.');

  });
}
