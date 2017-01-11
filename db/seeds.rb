Group.create!(:title=>'admin')
Group.create!(:title=>'manage')
Group.create!(:title=>'user')
Group.create!(:title=>'viewer')

User.create!(:group_id=>1,:email => 'fome234@nate.com', :nickname=>'예쁜-수정', :password => 'jjh123456', :password_confirmation => 'jjh123456',:photo=>File.open(Rails.root.join("app", "assets", "images", "intro", "image.jpg")), :admin=>1)
User.create!(:group_id=>1,:email => 'toughjjh@gmail.com', :nickname=>'잠자는-사자', :password => 'jjh123456', :password_confirmation => 'jjh123456',:photo=>File.open(Rails.root.join("app", "assets", "images", "intro", "sl.jpg")), :admin=>1)

AdPosition.create!(:id=>1,:title=>'광고 표시안함',:position=>'none')
AdPosition.create!(:id=>2,:title=>'위에 표시',:position=>'top')
AdPosition.create!(:id=>3,:title=>'아래에 표시',:position=>'bottom')

Resource.create!(:id=>1,:ad_position_id=>3,:title=>'메인',:menu_display=>false,:controller=>'home',:description=>'처음화면',:priority=>9000)
Resource.create!(:id=>2,:ad_position_id=>3,:title=>'소개',:menu_display=>true,:controller=>'intro',:description=>'소개',:priority=>1000)
Resource.create!(:id=>3,:ad_position_id=>2,:title=>'갤러리',:menu_display=>true,:controller=>'galleries',:use_category=>true,:description=>'갤러리',:priority=>2000)
Resource.create!(:id=>4,:ad_position_id=>2,:title=>'블로그',:menu_display=>true,:controller=>'blogs',:use_category=>true,:description=>'블로그',:priority=>3000)
Resource.create!(:id=>5,:ad_position_id=>2,:title=>'질문, 답변',:menu_display=>true,:controller=>'questions',:description=>'질문,답변',:priority=>4000)
Resource.create!(:id=>6,:ad_position_id=>2,:title=>'FAQ',:menu_display=>true,:controller=>'faqs',:use_category=>true,:description=>'FAQ',:priority=>5000)
Resource.create!(:id=>7,:ad_position_id=>2,:title=>'상담,문의',:menu_display=>false,:controller=>'contacts',:menu_action=>'new',:description=>'상담 문의를 받을수 있게 합니다.',:priority=>6000)
Resource.create!(:id=>8,:ad_position_id=>1,:title=>'공지사항',:menu_display=>false,:controller=>'notices',:description=>'운영자가 방문자들에게 알릴 공지사항을 알릴수 있게 합니다.',:priority=>7000)
Resource.create!(:id=>9,:ad_position_id=>2,:title=>'방명록',:menu_display=>true,:controller=>'guest_books',:description=>'방문자가 글을 쓸수 있는 방명록입니다.',:priority=>8000)
Resource.create!(:id=>10,:ad_position_id=>2,:title=>'연혁',:menu_display=>false,:controller=>'histories',:description=>'연혁',:priority=>8000)
Resource.create!(:id=>11,:ad_position_id=>2,:title=>'포트폴리오',:menu_display=>false,:controller=>'portfolios',:description=>'포트폴리오',:priority=>8000)
Resource.create!(:id=>12,:ad_position_id=>2,:title=>'회원가입',:menu_display=>false,:controller=>'users',:menu_action=>'new',:description=>'사용자',:priority=>9000)
Resource.create!(:id=>13,:ad_position_id=>2,:title=>'사이트',:menu_display=>false,:controller=>'site',:menu_action=>'new',:description=>'사이트 소개',:priority=>9000)

ResourcePhoto.create!(:id=>2,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu1.jpg")),:alt=>'수정이는?')
ResourcePhoto.create!(:id=>3,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu2.jpg")),:alt=>'수정이 사진첩')
ResourcePhoto.create!(:id=>4,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu3.jpg")),:alt=>'블로그')
ResourcePhoto.create!(:id=>5,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu4.jpg")),:alt=>'질문, 답변')
ResourcePhoto.create!(:id=>6,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu5.jpg")),:alt=>'FAQ')
ResourcePhoto.create!(:id=>9,:photo=>File.open(Rails.root.join("app", "assets", "images", "menu6.jpg")),:alt=>'방명록')

#BlogType.create!(:id=>1,:title=>'일반형')
#BlogType.create!(:id=>2,:title=>'게시판형')
#BlogType.create!(:id=>3,:title=>'갤러리형')

BlogCategory.create!(:id=>1,:user_id=>1,:title=>'일상')
BlogCategory.create!(:id=>2,:user_id=>1,:title=>'요리')

Intro.create!(:id=>1,:title=>'이름',:description=>'인수정')
Intro.create!(:id=>2,:title=>'나이',:description=>Time.now.year-1980)
Intro.create!(:id=>3,:title=>'키',:description=>'162.5cm')
Intro.create!(:id=>4,:title=>'몸무게',:description=>'00kg(알아서 뭐하게???)')
Intro.create!(:id=>5,:title=>'size',:description=>'쭉쭉은 못되도 빵빵은 됨')
Intro.create!(:id=>6,:title=>'취미',:description=>'정종호 사랑하기♡')
Intro.create!(:id=>7,:title=>'특기',:description=>'애교,요리')

GalleryCategory.create!(:id=>1,:user_id=>1,:title=>'수정이')
GalleryCategory.create!(:id=>2,:user_id=>1,:title=>'남편')
GalleryCategory.create!(:id=>3,:user_id=>1,:title=>'아들')
GalleryCategory.create!(:id=>4,:user_id=>1,:title=>'멍멍이')
GalleryCategory.create!(:id=>5,:user_id=>1,:title=>'풍경')
    
Notice.create!(:id=>1,:user_id=>1,:title=>'예쁘고 귀여운 수정이의 집이 다시 개장했습니다.')
NoticeContent.create!(:id=>1,:content=>'그동안 수많은 방문자에 비해서 준비되지 못하였는데 이제 보다 업그레이드된 모습으로 다시 찾아뵙게되었습니다.
    수정이와 소통하는 공간으로 계속 많은 이용바랍니다.')
    
FaqCategory.create!(:user_id=>1,:title=>'수정이 미모')
FaqCategory.create!(:user_id=>1,:title=>'수정이 애교')
FaqCategory.create!(:user_id=>1,:title=>'잘생긴 남친')
FaqCategory.create!(:user_id=>1,:title=>'멍멍이')

Faq.create!(:faq_category_id=>1,:id=>1,:title=>'수정이는 어떻게 이렇게 이쁜가요?')
Faq.create!(:faq_category_id=>1,:id=>2,:title=>'수정이는  목이 어떻게 그리 긴가요?')
Faq.create!(:faq_category_id=>1,:id=>3,:title=>'키가 약간 아쉽내요?')     
Faq.create!(:faq_category_id=>2,:id=>4,:title=>'수정이 애교를 배우고 싶어요')
Faq.create!(:faq_category_id=>2,:id=>5,:title=>'나이를 생각해서 애교를 삼가야 되지 않을까요?')
Faq.create!(:faq_category_id=>3,:id=>6,:title=>'남자친구는 누구이고 어떻게 저렇게 잘생겼나요?')
Faq.create!(:faq_category_id=>3,:id=>7,:title=>'생긴만큼 얼굴값을 하겠네요?')
Faq.create!(:faq_category_id=>4,:id=>8,:title=>'짬순이? 멍군이?')
Faq.create!(:faq_category_id=>4,:id=>9,:title=>'너무나 귀엽네요, 다들 잘 있나요?') 

FaqContent.create!(:id=>1,:content=>'원래 태어날때부터 예뻤습니다.')
FaqContent.create!(:id=>2,:content=>'사슴처럼 긴목 또한 태어날때부터 길었습니다.')
FaqContent.create!(:id=>3,:content=>'대신 빵빵한 가슴과 배로 커버하고 있습니다.')    
FaqContent.create!(:id=>4,:content=>'애교의 기본은 혀짮은 소리입니다.  앙앙, 귀엽게 앙!~ 하세요')    
FaqContent.create!(:id=>5,:content=>'나이는 숫자일뿐, 귀여운 수정이의 애교는 계속 됩니다.')
FaqContent.create!(:id=>6,:content=>'별명은 잠자는-사자이며 잘생긴 얼굴로 모든 여자들의 마음을 뺏어버리는 남자입니다') 
FaqContent.create!(:id=>7,:content=>'아닙니다. 선입견으로 그렇게 생각하기 쉬운데 성격은 얼굴보다 더 멋집니다.')
FaqContent.create!(:id=>8,:content=>'귀여운 짬순이는 말티즈 암컷으로 귀여운 멍군이를 낳았습니다')
FaqContent.create!(:id=>9,:content=>'종호의 사랑을 받으며 개팔자가 상팔자란 말 처럼 잘먹고 잘살고 있습니다.')


GuestBook.create!(:id=>1,:user_id=>1,:title=>'수정이의 집이 다시 열렸어요~~')
GuestBookContent.create!(:id=>1,:content=>'업데이트를 마치고 수정이의 집이 다시 열렸습니다.
그 동안 방문했다가 돌아간 수천만명의 방문객들에게 죄송스러운 마음이며
앞으로는 절대 닫히는 일없는 예쁜 수정이의 집이 되겠습니다.')

Question.create!(:id=>1,:name=>'방문자',:title=>'수정이는 어떻게 그렇게 예쁜가요??')
QuestionContent.create!(:id=>1,:content=>'저도 수정이의 반만큼만 예뻤으면 좋겠어요....... ㅠ.ㅠ
제발 방법좀 가르쳐 주세요.')

bc1=BlogCategory.find(1)
bc2=BlogCategory.find(2)

gc1=GalleryCategory.find(1)
gc2=GalleryCategory.find(2)
gc3=GalleryCategory.find(3)
gc4=GalleryCategory.find(4)
gc5=GalleryCategory.find(5)

I18n.locale=:en

#bt1.title='common'
#bt1.save
#bt2.title='board'
#bt2.save
#bt3.title='gallery'
#bt3.save 

bc1.title='common'
bc1.save
bc2.title='recipe'
bc2.save

gc1.title='soojung'
gc1.save
gc2.title='husband'
gc2.save
gc3.title='son'
gc3.save
gc4.title='dogs'
gc4.save
gc5.title='landscape'
gc5.save

I18n.locale='zh-CN'

#bt1.title='一般'
#bt1.save
#bt2.title='板'
#bt2.save
#bt3.title='画廊'
#bt3.save 

bc1.title='一般'
bc1.save
bc2.title='食谱'
bc2.save

gc1.title='印水晶(我)'
gc1.save
gc2.title='丈夫'
gc2.save
gc3.title='儿子'
gc3.save
gc4.title='狗'
gc4.save
gc5.title='景观'
gc5.save

I18n.locale='ja'

#bt1.title='一般'
#bt1.save
#bt2.title='板'
#bt2.save
#bt3.title='画廊'
#bt3.save 

bc1.title='一般'
bc1.save
bc2.title='料理法'
bc2.save

gc1.title='印水晶(私)'
gc1.save
gc2.title='旦那'
gc2.save
gc3.title='息子'
gc3.save
gc4.title='犬'
gc4.save
gc5.title='風景'
gc5.save

