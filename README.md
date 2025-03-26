# trtenten20-unigram

trTenTen20 derlemin kaynağından kazınarak alındı.

## Süreç ...

Doğal Dil İşleme yöntemleri kullanarak kasıtlı olarak yanlış yazılmış (bir tür atlatma yöntemi olarak) metinleri analizmem gerekiyordu. Ancak yeterli kalitede (boyut ve doğruluk olarak) bir Türkçe kelime listesi bulmakta zorluk yaşadığım için betiği kullanarak bir derlemi kazımayı denedim. (En azında bir kısmı için başarılı oldu.)

Bu repoda paylaşılan betikler tam otomatik olarak çalıştırılmaya uygun değiller. scrape.sh bir süre çalıştıktan derlemin önemli bir kısmını, yani yüksek frekanslı olan sözcükleri kazıdıktan sonra 1000 kayıt olan sorgu sonucunda yeni max-freq değeri olarak son kullanılan ile aynı değeri buluyor. Buradan sonra ikinci betik ile belirli harfler ile başlayan kelimeleri kazımaya devam ettim.

Bu betikleri aynı kaynaktan veri kazımak isteyen başkalarına fikir vermesi amacıyla paylaşıyorum.

Günlerce interneti taradıktan sonra daha fazla kaynağa aşağıdaki bağlantılardan ulaştım:

- https://www.denizyuret.com/2006/11/turkish-resources.html
- https://wortschatz.uni-leipzig.de/en/download/Turkish
- https://tulap.cmpe.boun.edu.tr/home
- https://turkishnlp.github.io/list/

Ben algoritmamı bu adresten temin ettiğim bir veri ile çalıştırmaya devam ediyorum. Bununla beraber benim çalışmam için sözlükte bir kelimenin varlığı ve yokluğu doğrudan başarıya etki ediyor. Bu nedenle sözlüğün zaman içerisinde güncellenebilmesi için bir derlem yönetim arayüzü entegre etmeyi hedefliyorum.

## Benim projem için AI kullansaydın diyenlere ithafen!

Bu günlerde yazılım alanında motive olmakta zorluk yaşıyorum, çözmeye azmettiğim her problemin AI ile çözülebileceğini düşününmek beni biraz tatminsiz bırakıyor. Geçmişte görüntü işleme ve yapay zeka ile ilgili okuduklarımdan birinde "Elinde çekiç varsa, her problem çivi gibi gözükür" şeklinde bir özlü söz aklıma geliyor. Problemlere optimal çözümler üretmemiz gerekiyor ki; AI her durumda optimal çözüm olmaktan çok uzak. O sadece bu en uygun çözümü üretmemizde kullanabileceğimiz bir araç.

Hoşçakalın!

## Bu proje terkedilmiştir!