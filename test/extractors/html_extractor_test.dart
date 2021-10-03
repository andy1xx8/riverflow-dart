import 'package:html/dom.dart';
import 'package:riverflow/src/extractors/html_extractor.dart';
import 'package:test/test.dart';

void main() {
  group('HTML Extractor tests', () {
    var html = '''
      <div class="mini-list-item">
        <a class="mini-list-item-title" href="/packages/device_info"><h3>device_info</h3></a>
        <div class="mini-list-item-body">
          <p class="mini-list-item-description">Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.</p>
        </div>
        <div class="mini-list-item-footer">
            <div class="mini-list-item-publisher">
              <img class="publisher-badge" src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol" title="Published by a pub.dev verified publisher">
              <a class="publisher-link" href="/publishers/flutter.dev">flutter.dev</a>
            </div>
        </div>
      </div>
      ''';

    test('Get package title show OK', () {
      var extractor = HtmlExtractor(
        selector: 'a[class="mini-list-item-title"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(result[0] == 'device_info', isTrue);

      print(result.map((e) => e.toString()).join(','));
    });

    test('Get package description show OK', () {
      var extractor = HtmlExtractor(
        selector: 'div[class="mini-list-item-body"] p[class="mini-list-item-description"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(
          result[0] ==
              'Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.',
          isTrue);
      print(result.map((e) => e.toString()).join(','));
    });
  });

  group('HTML Exclude Extractor tests', () {
    var html = '''
      <div class="mini-list-item">
        <a class="mini-list-item-title" href="/packages/device_info"><h3>device_info</h3></a>
        <div class="mini-list-item-body">
          <p class="mini-list-item-description">Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.</p>
        </div>
        <div class="mini-list-item-footer">
            <div class="mini-list-item-publisher">
              <img class="publisher-badge" src="/static/img/verified-publisher-gray.svg?hash=je610l58nj7vkvrdmrhakp3npkle6iol" title="Published by a pub.dev verified publisher">
              <a class="publisher-link" href="/publishers/flutter.dev">flutter.dev</a>
            </div>
        </div>
      </div>
      ''';

    test('Remove package title show OK', () {
      var extractor = HtmlExcludeExtractor(
        selector: 'a[class="mini-list-item-title"]',
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect((result[0] as Element).text != 'device_info', isTrue);
      print(result.map((e) => e.toString()).join(','));
    });

    test('Get package description show OK', () {
      var extractor = HtmlExtractor(
        selector: 'div[class="mini-list-item-body"] p[class="mini-list-item-description"]',
        collectors: ['\$\{text()\}'],
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);
      expect(
          result[0] ==
              'Flutter plugin providing detailed information about the device (make, model, etc.), and Android or iOS version the app is running on.',
          isTrue);
      print(result.map((e) => e.toString()).join(','));
    });
  });


  group('HTML Contains Extractor tests', () {
    var html = '''
<li data-href="/u/hackerry.352292/about" role="tabpanel" aria-labelledby="about" class="is-active" aria-expanded="true"><div class="block">
	<div class="block-container">
		<div class="block-body">
		
		
			
				<div class="block-row block-row--separated">
					<div class="bbWrapper">ﻦﻩﻹ ﻍﻻﻩﺄ ﺃ <br>
»--ﺓﺃﯞ--»</div>
				</div>
			

			
				<div class="block-row block-row--separated">
				
					

					

					
						<dl class="pairs pairs--columns pairs--fixedSmall">
							<dt>Location</dt>
							<dd>
								
									<a href="/misc/location-info?location=%E2%80%A2%28%E2%99%A5%29.%E2%80%A2%D2%89%C2%B4%C2%A8%60+%E0%B9%96%DB%A3%DB%9CR%C2%A5+%E0%B9%96%DB%A3%DB%9C%C6%9C%C8%AB%C8%91%C6%AAd+%D2%89%C2%B4%C2%A8%60%E2%80%A2.%28%E2%99%A5%29%E2%80%A2" rel="nofollow noreferrer" target="_blank" class="u-concealed">•(♥).•҉´¨` ๖ۣۜR¥ ๖ۣۜƜȫȑƪd ҉´¨`•.(♥)•</a>
								
							</dd>
						</dl>
					

					

	

				
				</div>
			

			

			
				<div class="block-row block-row--separated">
					<h4 class="block-textHeader">Signature</h4>
					<div class="bbWrapper"><i>Vùng đất thơm hoa đào rơi...</i><br>
ﴽﯟ ﹻﹿﹻﹻﹿﹻﻬὄ ﻬﹹﹱﹹﹹﹱﹽﹹ<br>
<i>Chuyên bàn chải Philips Sonicare xịn </i></div>
				</div>
			

			
				
					<div class="block-row block-row--separated">
						<h4 class="block-textHeader">Following</h4>
						<ul class="listHeap">
							
								
									<li>
										<a href="/u/ryxinkxink.1736419/" class="avatar avatar--s" data-user-id="1736419" data-xf-init="member-tooltip" id="js-XFUniqueId272">
			<img src="/data/avatars/s/1736/1736419.jpg?1621494447" srcset="/data/avatars/m/1736/1736419.jpg?1621494447 2x" alt="ryxinkxink" class="avatar-u1736419-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/fongsg.1724807/" class="avatar avatar--s" data-user-id="1724807" data-xf-init="member-tooltip" id="js-XFUniqueId273">
			<img src="/data/avatars/s/1724/1724807.jpg?1622363077" srcset="/data/avatars/m/1724/1724807.jpg?1622363077 2x" alt="FongSG" class="avatar-u1724807-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/kiruaz.1702346/" class="avatar avatar--s" data-user-id="1702346" data-xf-init="member-tooltip" id="js-XFUniqueId274">
			<img src="/data/avatars/s/1702/1702346.jpg?1614352013" srcset="/data/avatars/m/1702/1702346.jpg?1614352013 2x" alt="Kiruaz" class="avatar-u1702346-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/nctaka-nay-can-ta-ky-a.1736389/" class="avatar avatar--s" data-user-id="1736389" data-xf-init="member-tooltip" id="js-XFUniqueId275">
			<img src="/data/avatars/s/1736/1736389.jpg?1621488442" srcset="/data/avatars/m/1736/1736389.jpg?1621488442 2x" alt="NCTaka (Nay Cân Tạ Ký Á)" class="avatar-u1736389-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/chu-tich-hoi-nong-dan.1674204/" class="avatar avatar--s" data-user-id="1674204" data-xf-init="member-tooltip" id="js-XFUniqueId276">
			<img src="/data/avatars/s/1674/1674204.jpg?1622459699" srcset="/data/avatars/m/1674/1674204.jpg?1622459699 2x" alt="Chủ Tịch Hội Nông Dân" class="avatar-u1674204-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/ry-tro-ngu.1735917/" class="avatar avatar--s" data-user-id="1735917" data-xf-init="member-tooltip" id="js-XFUniqueId277">
			<img src="/data/avatars/s/1735/1735917.jpg?1621341102" srcset="/data/avatars/m/1735/1735917.jpg?1621341102 2x" alt="Ry Tró Ngu" class="avatar-u1735917-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/meo-care.1678855/" class="avatar avatar--s" data-user-id="1678855" data-xf-init="member-tooltip" id="js-XFUniqueId278">
			<img src="/data/avatars/s/1678/1678855.jpg?1632977056" srcset="/data/avatars/m/1678/1678855.jpg?1632977056 2x" alt="Méo Care" class="avatar-u1678855-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/lolita_07.1344895/" class="avatar avatar--s" data-user-id="1344895" data-xf-init="member-tooltip" id="js-XFUniqueId279">
			<img src="/data/avatars/s/1344/1344895.jpg?1615253360" srcset="/data/avatars/m/1344/1344895.jpg?1615253360 2x" alt="lolita_07" class="avatar-u1344895-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/sour-candy.1680594/" class="avatar avatar--s" data-user-id="1680594" data-xf-init="member-tooltip" id="js-XFUniqueId280">
			<img src="/data/avatars/s/1680/1680594.jpg?1622199274" srcset="/data/avatars/m/1680/1680594.jpg?1622199274 2x" alt="Sour Candy" class="avatar-u1680594-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/anh-cu-ti.1723423/" class="avatar avatar--s" data-user-id="1723423" data-xf-init="member-tooltip" id="js-XFUniqueId281">
			<img src="/data/avatars/s/1723/1723423.jpg?1622537584" srcset="/data/avatars/m/1723/1723423.jpg?1622537584 2x" alt="Anh Cu Tí" class="avatar-u1723423-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/cong-ty-tnhh-ung-gach.1731466/" class="avatar avatar--s" data-user-id="1731466" data-xf-init="member-tooltip" id="js-XFUniqueId282">
			<img src="/data/avatars/s/1731/1731466.jpg?1619815372" srcset="/data/avatars/m/1731/1731466.jpg?1619815372 2x" alt="Công ty TNHH Ưng/Gạch" class="avatar-u1731466-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/diem-nhon.1691653/" class="avatar avatar--s" data-user-id="1691653" data-xf-init="member-tooltip" id="js-XFUniqueId283">
			<img src="/data/avatars/s/1691/1691653.jpg?1633195668" srcset="/data/avatars/m/1691/1691653.jpg?1633195668 2x" alt="Diễm Nhợn" class="avatar-u1691653-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
							
						</ul>
						
							<a href="/u/hackerry.352292/following/" data-xf-click="overlay">... and 19 more.</a>
						
					</div>
				
			

			
				
					<div class="block-row block-row--separated">
						<h4 class="block-textHeader">Followers</h4>
						<ul class="listHeap">
							
								
									<li>
										<a href="/u/finnula-crais.1674013/" class="avatar avatar--s" data-user-id="1674013" data-xf-init="member-tooltip" id="js-XFUniqueId284">
			<img src="/data/avatars/s/1674/1674013.jpg?1590414333" srcset="/data/avatars/m/1674/1674013.jpg?1590414333 2x" alt="Finnula Crais" class="avatar-u1674013-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/chubao.1761607/" class="avatar avatar--s" data-user-id="1761607" data-xf-init="member-tooltip" id="js-XFUniqueId285">
			<img src="/data/avatars/s/1761/1761607.jpg?1630428259" srcset="/data/avatars/m/1761/1761607.jpg?1630428259 2x" alt="chubao" class="avatar-u1761607-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/dukefung.1767660/" class="avatar avatar--s" data-user-id="1767660" data-xf-init="member-tooltip" id="js-XFUniqueId286">
			<img src="/data/avatars/s/1767/1767660.jpg?1632896369" srcset="/data/avatars/m/1767/1767660.jpg?1632896369 2x" alt="dukefung" class="avatar-u1767660-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/huyhoang0936.1644153/" class="avatar avatar--s" data-user-id="1644153" data-xf-init="member-tooltip" id="js-XFUniqueId287">
			<img src="/data/avatars/s/1644/1644153.jpg?1630841030" srcset="/data/avatars/m/1644/1644153.jpg?1630841030 2x" alt="huyhoang0936" class="avatar-u1644153-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/ledat2399.1713583/" class="avatar avatar--s" data-user-id="1713583" data-xf-init="member-tooltip" id="js-XFUniqueId288">
			<img src="/data/avatars/s/1713/1713583.jpg?1620960166" srcset="/data/avatars/m/1713/1713583.jpg?1620960166 2x" alt="Ledat2399" class="avatar-u1713583-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/things-will-get-better.1692987/" class="avatar avatar--s" data-user-id="1692987" data-xf-init="member-tooltip" id="js-XFUniqueId289">
			<img src="/data/avatars/s/1692/1692987.jpg?1605377590" srcset="/data/avatars/m/1692/1692987.jpg?1605377590 2x" alt="Things will get better" class="avatar-u1692987-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/tra-dao-cam-sa.1687846/" class="avatar avatar--s" data-user-id="1687846" data-xf-init="member-tooltip" id="js-XFUniqueId290">
			<img src="/data/avatars/s/1687/1687846.jpg?1601607984" srcset="/data/avatars/m/1687/1687846.jpg?1601607984 2x" alt="Trà Đào Cam Sả" class="avatar-u1687846-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/rydory.1731132/" class="avatar avatar--s" data-user-id="1731132" data-xf-init="member-tooltip" id="js-XFUniqueId291">
			<img src="/data/avatars/s/1731/1731132.jpg?1632638067" srcset="/data/avatars/m/1731/1731132.jpg?1632638067 2x" alt="rydory" class="avatar-u1731132-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/partey.1677056/" class="avatar avatar--s" data-user-id="1677056" data-xf-init="member-tooltip" id="js-XFUniqueId292">
			<img src="/data/avatars/s/1677/1677056.jpg?1604577164" srcset="/data/avatars/m/1677/1677056.jpg?1604577164 2x" alt="partey" class="avatar-u1677056-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/betruonglonton.1739837/" class="avatar avatar--s" data-user-id="1739837" data-xf-init="member-tooltip" id="js-XFUniqueId293">
			<img src="/data/avatars/s/1739/1739837.jpg?1622279181" srcset="/data/avatars/m/1739/1739837.jpg?1622279181 2x" alt="betruonglonton" class="avatar-u1739837-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/thanhphuong03.1767662/" class="avatar avatar--s" data-user-id="1767662" data-xf-init="member-tooltip" id="js-XFUniqueId294">
			<img src="/data/avatars/s/1767/1767662.jpg?1632897486" srcset="/data/avatars/m/1767/1767662.jpg?1632897486 2x" alt="thanhphuong03" class="avatar-u1767662-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/ca-phe-sua-da.1689214/" class="avatar avatar--s" data-user-id="1689214" data-xf-init="member-tooltip" id="js-XFUniqueId295">
			<img src="/data/avatars/s/1689/1689214.jpg?1632221495" srcset="/data/avatars/m/1689/1689214.jpg?1632221495 2x" alt="Cà Phê Sữa Đá." class="avatar-u1689214-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
							
						</ul>
						
							<a href="/u/hackerry.352292/followers/" data-xf-click="overlay">... and 16 more.</a>
						
					</div>
				
			

			
				<div class="block-row block-row--separated">
					<h4 class="block-textHeader">Trophies</h4>
					<ol class="listPlain">
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">30</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-06-21T15:40:01+0700" data-time="1592728801" data-date-string="Jun 21, 2020" data-time-string="3:40 PM" title="Jun 21, 2020 at 3:40 PM">Jun 21, 2020</time></span>
										<h2 class="contentRow-header">I LOVE IT!</h2>
										<div class="contentRow-minor">Content you have posted has attracted 500 positive reactions.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">20</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-06-12T13:59:29+0700" data-time="1591945169" data-date-string="Jun 12, 2020" data-time-string="1:59 PM" title="Jun 12, 2020 at 1:59 PM">Jun 12, 2020</time></span>
										<h2 class="contentRow-header">Can't get enough of your stuff</h2>
										<div class="contentRow-minor">Your content has been positively reacted to 250 times.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">15</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-05-10T20:40:43+0700" data-time="1589118043" data-date-string="May 10, 2020" data-time-string="8:40 PM" title="May 10, 2020 at 8:40 PM">May 10, 2020</time></span>
										<h2 class="contentRow-header">Seriously likeable!</h2>
										<div class="contentRow-minor">Content you have posted has attracted a positive reaction score of 100.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">10</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-10T16:40:43+0700" data-time="1583833243" data-date-string="Mar 10, 2020" data-time-string="4:40 PM" title="Mar 10, 2020 at 4:40 PM">Mar 10, 2020</time></span>
										<h2 class="contentRow-header">I like it a lot</h2>
										<div class="contentRow-minor">Your messages have been positively reacted to 25 times.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">2</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-09T15:41:00+0700" data-time="1583743260" data-date-string="Mar 9, 2020" data-time-string="3:41 PM" title="Mar 9, 2020 at 3:41 PM">Mar 9, 2020</time></span>
										<h2 class="contentRow-header">Somebody likes you</h2>
										<div class="contentRow-minor">Somebody out there reacted positively to one of your messages. Keep posting like that for more!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">20</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-07T02:48:13+0700" data-time="1583524093" data-date-string="Mar 7, 2020" data-time-string="2:48 AM" title="Mar 7, 2020 at 2:48 AM">Mar 7, 2020</time></span>
										<h2 class="contentRow-header">Addicted</h2>
										<div class="contentRow-minor">1,000 messages? Impressive!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">10</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-07T02:48:13+0700" data-time="1583524093" data-date-string="Mar 7, 2020" data-time-string="2:48 AM" title="Mar 7, 2020 at 2:48 AM">Mar 7, 2020</time></span>
										<h2 class="contentRow-header">Can't stop!</h2>
										<div class="contentRow-minor">You've posted 100 messages. I hope this took you more than a day!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">5</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-07T02:48:13+0700" data-time="1583524093" data-date-string="Mar 7, 2020" data-time-string="2:48 AM" title="Mar 7, 2020 at 2:48 AM">Mar 7, 2020</time></span>
										<h2 class="contentRow-header">Keeps coming back</h2>
										<div class="contentRow-minor">30 messages posted. You must like it here!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">1</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-07T02:48:13+0700" data-time="1583524093" data-date-string="Mar 7, 2020" data-time-string="2:48 AM" title="Mar 7, 2020 at 2:48 AM">Mar 7, 2020</time></span>
										<h2 class="contentRow-header">First message</h2>
										<div class="contentRow-minor">Post a message somewhere on the site to receive this.</div>
									</div>
								</div>
							</li>
						
					</ol>
				</div>
			
		
		
		</div>
	</div>
</div></li>
      ''';

    test('Get Signature should OK', () {
      var extractor = HtmlContainsExtractor(
        selector: 'div[class*="block-body"] div[class*="block-row--separated"]',
        containSelector: 'h4[class*="block-textHeader"]'
      );

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);

      print('Total elements: ${result.length}');
      result.forEach((e){
        print((e as Element).text);

        print('\n----------------------\n');
      });
    });

  });

}
