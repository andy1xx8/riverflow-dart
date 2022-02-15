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
    <li data-href="/u/zulu.3269/about" role="tabpanel" aria-labelledby="about" class="is-active" aria-expanded="true"><div class="block">
	<div class="block-container">
		<div class="block-body">
		
		
			
				<div class="block-row block-row--separated">
					<div class="bbWrapper">Kkkkk</div>
				</div>
			

			
				<div class="block-row block-row--separated">
				
					

					

					
						<dl class="pairs pairs--columns pairs--fixedSmall">
							<dt>Location</dt>
							<dd>
								
									<a href="/misc/location-info?location=ABC" rel="nofollow noreferrer" target="_blank" class="u-concealed">ABC</a>
								
							</dd>
						</dl>
					

					

	

				
				</div>
			

			
				
			

			
				<div class="block-row block-row--separated">
					<h4 class="block-textHeader">Signature</h4>
					<div class="bbWrapper"><b>VOZ.VN app<br>
Android<br>
iOS</b></div>
				</div>
			

			
				
					<div class="block-row block-row--separated">
						<h4 class="block-textHeader">Following</h4>
						<ul class="listHeap">
							
								
									<li>
										<a href="/u/tieusoai2k.1673530/" class="avatar avatar--s" data-user-id="1673530" data-xf-init="member-tooltip" id="js-XFUniqueId186">
			<img src="/data/avatars/s/1673/1673530.jpg?1584239582" srcset="/data/avatars/m/1673/1673530.jpg?1584239582 2x" alt="tieusoai2k" class="avatar-u1673530-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/manhcuong18.1489807/" class="avatar avatar--s avatar--default avatar--default--dynamic" data-user-id="1489807" data-xf-init="member-tooltip" style="background-color: #29a347; color: #051409" id="js-XFUniqueId187">
			<span class="avatar-u1489807-s" role="img" aria-label="manhcuong18">M</span> 
		</a>
									</li>
								
									<li>
										<a href="/u/chiriengminhta2204.1672371/" class="avatar avatar--s" data-user-id="1672371" data-xf-init="member-tooltip" id="js-XFUniqueId188">
			<img src="/data/avatars/s/1672/1672371.jpg?1584318628" srcset="/data/avatars/m/1672/1672371.jpg?1584318628 2x" alt="chiriengminhta2204" class="avatar-u1672371-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/chatlog.967959/" class="avatar avatar--s" data-user-id="967959" data-xf-init="member-tooltip" id="js-XFUniqueId189">
			<img src="/data/avatars/s/967/967959.jpg?1584197721" srcset="/data/avatars/m/967/967959.jpg?1584197721 2x" alt="chatlog" class="avatar-u967959-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/ban-long-cong-tu.1706561/" class="avatar avatar--s" data-user-id="1706561" data-xf-init="member-tooltip" id="js-XFUniqueId190">
			<img src="/data/avatars/s/1706/1706561.jpg?1627195054" srcset="/data/avatars/m/1706/1706561.jpg?1627195054 2x" alt="Bần Lông Công Tử" class="avatar-u1706561-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/phobuon20.1267818/" class="avatar avatar--s" data-user-id="1267818" data-xf-init="member-tooltip" id="js-XFUniqueId191">
			<img src="/data/avatars/s/1267/1267818.jpg?1609840504" srcset="/data/avatars/m/1267/1267818.jpg?1609840504 2x" alt="phobuon20" class="avatar-u1267818-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/18cm30p.1224580/" class="avatar avatar--s" data-user-id="1224580" data-xf-init="member-tooltip" id="js-XFUniqueId192">
			<img src="/data/avatars/s/1224/1224580.jpg?1603362167" srcset="/data/avatars/m/1224/1224580.jpg?1603362167 2x" alt="18cm30p" class="avatar-u1224580-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/revesi.1334830/" class="avatar avatar--s" data-user-id="1334830" data-xf-init="member-tooltip" id="js-XFUniqueId193">
			<img src="/data/avatars/s/1334/1334830.jpg?1584497249" srcset="/data/avatars/m/1334/1334830.jpg?1584497249 2x" alt="[Revesi]" class="avatar-u1334830-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/d-ragon.622573/" class="avatar avatar--s" data-user-id="622573" data-xf-init="member-tooltip" id="js-XFUniqueId194">
			<img src="/data/avatars/s/622/622573.jpg?1618762912" srcset="/data/avatars/m/622/622573.jpg?1618762912 2x" alt="[D]ragon" class="avatar-u622573-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/sekiro.1671905/" class="avatar avatar--s" data-user-id="1671905" data-xf-init="member-tooltip" id="js-XFUniqueId195">
			<img src="/data/avatars/s/1671/1671905.jpg?1589388165" srcset="/data/avatars/m/1671/1671905.jpg?1589388165 2x" alt="Sekiro" class="avatar-u1671905-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/gentlely.1669917/" class="avatar avatar--s" data-user-id="1669917" data-xf-init="member-tooltip" id="js-XFUniqueId196">
			<img src="/data/avatars/s/1669/1669917.jpg?1603219489" srcset="/data/avatars/m/1669/1669917.jpg?1603219489 2x" alt="Gentlely" class="avatar-u1669917-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/meoso123.1049915/" class="avatar avatar--s" data-user-id="1049915" data-xf-init="member-tooltip" id="js-XFUniqueId197">
			<img src="/data/avatars/s/1049/1049915.jpg?1628874157" srcset="/data/avatars/m/1049/1049915.jpg?1628874157 2x" alt="meoso123" class="avatar-u1049915-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
							
						</ul>
						
							<a href="/u/zulu.3269/following/" data-xf-click="overlay">... and 2 more.</a>
						
					</div>
				
			

			
				
					<div class="block-row block-row--separated">
						<h4 class="block-textHeader">Followers</h4>
						<ul class="listHeap">
							
								
									<li>
										<a href="/u/dreadout.1760847/" class="avatar avatar--s" data-user-id="1760847" data-xf-init="member-tooltip" id="js-XFUniqueId198">
			<img src="/data/avatars/s/1760/1760847.jpg?1630851268" srcset="/data/avatars/m/1760/1760847.jpg?1630851268 2x" alt="dreadout" class="avatar-u1760847-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/kjsslv.1116873/" class="avatar avatar--s avatar--default avatar--default--dynamic" data-user-id="1116873" data-xf-init="member-tooltip" style="background-color: #ccadeb; color: #732eb8" id="js-XFUniqueId199">
			<span class="avatar-u1116873-s" role="img" aria-label="kjsslv">K</span> 
		</a>
									</li>
								
									<li>
										<a href="/u/subairashi333.1673876/" class="avatar avatar--s" data-user-id="1673876" data-xf-init="member-tooltip" id="js-XFUniqueId200">
			<img src="/data/avatars/s/1673/1673876.jpg?1585159386" srcset="/data/avatars/m/1673/1673876.jpg?1585159386 2x" alt="subairashi333" class="avatar-u1673876-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/harrypipi.1425267/" class="avatar avatar--s" data-user-id="1425267" data-xf-init="member-tooltip" id="js-XFUniqueId201">
			<img src="/data/avatars/s/1425/1425267.jpg?1627882535" srcset="/data/avatars/m/1425/1425267.jpg?1627882535 2x" alt="harrypipi" class="avatar-u1425267-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/sev7l0ve.806446/" class="avatar avatar--s" data-user-id="806446" data-xf-init="member-tooltip" id="js-XFUniqueId202">
			<img src="/data/avatars/s/806/806446.jpg?1584151030" srcset="/data/avatars/m/806/806446.jpg?1584151030 2x" alt="sev7l0ve" class="avatar-u806446-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
									<li>
										<a href="/u/tng2903.171365/" class="avatar avatar--s" data-user-id="171365" data-xf-init="member-tooltip" id="js-XFUniqueId203">
			<img src="/data/avatars/s/171/171365.jpg?1603251361" alt="TnG2903" class="avatar-u171365-s" width="48" height="48" loading="lazy"> 
		</a>
									</li>
								
							
						</ul>
						
					</div>
				
			

			
				<div class="block-row block-row--separated">
					<h4 class="block-textHeader">Trophies</h4>
					<ol class="listPlain">
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">20</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-05-27T18:40:17+0700" data-time="1590579617" data-date-string="May 27, 2020" data-time-string="6:40 PM" title="May 27, 2020 at 6:40 PM">May 27, 2020</time></span>
										<h2 class="contentRow-header">Addicted</h2>
										<div class="contentRow-minor">1,000 messages? Impressive!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">30</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-05-03T11:40:44+0700" data-time="1588480844" data-date-string="May 3, 2020" data-time-string="11:40 AM" title="May 3, 2020 at 11:40 AM">May 3, 2020</time></span>
										<h2 class="contentRow-header">I LOVE IT!</h2>
										<div class="contentRow-minor">Content you have posted has attracted 500 positive reactions.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">20</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-04-06T00:40:35+0700" data-time="1586108435" data-date-string="Apr 6, 2020" data-time-string="12:40 AM" title="Apr 6, 2020 at 12:40 AM">Apr 6, 2020</time></span>
										<h2 class="contentRow-header">Can't get enough of your stuff</h2>
										<div class="contentRow-minor">Your content has been positively reacted to 250 times.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">15</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-28T23:40:39+0700" data-time="1585413639" data-date-string="Mar 28, 2020" data-time-string="11:40 PM" title="Mar 28, 2020 at 11:40 PM">Mar 28, 2020</time></span>
										<h2 class="contentRow-header">Seriously likeable!</h2>
										<div class="contentRow-minor">Content you have posted has attracted a positive reaction score of 100.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">10</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-20T15:03:31+0700" data-time="1584691411" data-date-string="Mar 20, 2020" data-time-string="3:03 PM" title="Mar 20, 2020 at 3:03 PM">Mar 20, 2020</time></span>
										<h2 class="contentRow-header">I like it a lot</h2>
										<div class="contentRow-minor">Your messages have been positively reacted to 25 times.</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">2</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-14T16:40:08+0700" data-time="1584178808" data-date-string="Mar 14, 2020" data-time-string="4:40 PM" title="Mar 14, 2020 at 4:40 PM">Mar 14, 2020</time></span>
										<h2 class="contentRow-header">Somebody likes you</h2>
										<div class="contentRow-minor">Somebody out there reacted positively to one of your messages. Keep posting like that for more!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">10</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-11T20:45:02+0700" data-time="1583934302" data-date-string="Mar 11, 2020" data-time-string="8:45 PM" title="Mar 11, 2020 at 8:45 PM">Mar 11, 2020</time></span>
										<h2 class="contentRow-header">Can't stop!</h2>
										<div class="contentRow-minor">You've posted 100 messages. I hope this took you more than a day!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">5</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-11T20:45:02+0700" data-time="1583934302" data-date-string="Mar 11, 2020" data-time-string="8:45 PM" title="Mar 11, 2020 at 8:45 PM">Mar 11, 2020</time></span>
										<h2 class="contentRow-header">Keeps coming back</h2>
										<div class="contentRow-minor">30 messages posted. You must like it here!</div>
									</div>
								</div>
							</li>
						
							<li class="block-row">
								<div class="contentRow">
									<span class="contentRow-figure contentRow-figure--text contentRow-figure--fixedSmall">1</span>
									<div class="contentRow-main">
										<span class="contentRow-extra"><time class="u-dt" dir="auto" datetime="2020-03-11T20:45:02+0700" data-time="1583934302" data-date-string="Mar 11, 2020" data-time-string="8:45 PM" title="Mar 11, 2020 at 8:45 PM">Mar 11, 2020</time></span>
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
          selector: 'div[class*="block-body"] > div[class*="block-row--separated"]',
          containSelector: 'h4[class*="block-textHeader"]');

      var result = extractor.extract(html);

      expect(result, isNotNull);
      expect(result, isNotEmpty);

      print('Total elements: ${result.length}');
      result.forEach((e) {
        print((e as Element).text);

        print('\n----------------------\n');
      });
    });
  });
}
