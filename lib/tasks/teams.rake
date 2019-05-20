task :build_teams => :environment do
  Team.destroy_all
  m = 0
  %{Jezevci	středisko Polaris Praha	Práčata	8	chlapecká	-	-	-	-	fejt.jirka@skaut.cz,daniel.hruby@centrum.cz
Albatrosové	4. přístav Jana Nerudy Praha	Albatrosové	8	chlapecká	-	-	-	-	firelotr@gmail.com
Horníci z Dejvic	18. středisko Kruh Praha	Chlapci	6	chlapecká	-	-	-	-	kolocero@gmail.com,kucera.matey@gmail.com
Káňata	34. středisko Ostříž Praha	145. oddíl skautů "Naděje"	7	chlapecká	-	-	-	-	fila.necas@gmail.com
Střelci	7. středisko Blaník Praha	Černý šíp	5	chlapecká	-	-	-	-	radiomatys@gmail.com,pribylsimon@email.cz
Sloni	středisko Oheň Horní Počernice	92. oddíl skautů Vatra	4	chlapecká	-	-	-	-	kozel@skaut.cz,gonzi413@gmail.com
Bro	středisko Stopaři Praha	Bronco	6	chlapecká	-	-	-	-	vojta.stanek@stopari.org
Šupáci	středisko Pplk. Vally Praha	107.skautský oddíl AVALON	4	chlapecká	-	-	-	-	dalibor@skaut.cz,seba.kouklik@gmail.com
Krakeni	středisko Maják Praha	Ignis	7	chlapecká	-	-	-	-	raki@skaut.cz
Omega	středisko 24 Sever Praha	24. oddíl skautů Orionis	4	chlapecká	-	-	-	-	Mozart.deda@seznam.cz,martin@smolikovi.cz
Šarlatoví beránci	středisko 55 Vatra Praha	96.oddíl Šipka	6	chlapecká	-	-	-	-	klikar@skaut.cz
Svišti	středisko STOVKA Praha	148. oddíl skautů a skautek RYS	6	chlapecká	-	-	-	-	masimmartin13@gmail.com
Blbouni	středisko Bílý los Praha	Ztracená Hvězda	6	dívčí	-	-	-	-	pastela135@seznam.cz,cyril.cmejrek@gmail.com
Vážky	středisko Bílý Albatros Praha	Argyroneta	5	dívčí	-	-	-	-	maruska.h@volny.cz
Squaw	7. středisko Blaník Praha	Říčany	5	dívčí	-	-	-	-	aniklimesova@gmail.com,nancy.matochova@gmail.com
Včely	středisko Hiawatha Praha	Minnehaha	8	dívčí	-	-	-	-	ruzazelva@gmail.com
Panteři	středisko Bílý los Praha	Ztracená Hvězda	6	dívčí	-	-	-	-	pastela135@seznam.cz,emuleta.zakova@gmail.com
Vlaštovky	středisko 24 Sever Praha	24.oddíl skautek	7	dívčí	-	-	-	-	kajushka.brabcova@seznam.cz,bara.narova@seznam.cz
Vidlačky	středisko Oheň Horní Počernice	92.oddíl skautek - Vlnky	7	dívčí	-	-	-	-	kolomaznikova.lucie@gmail.com
DĚBENKY beta	přístav Pětka Praha	Děbenky	5	dívčí	-	-	-	-	tereza.stachovaa@gmail.com
Potkani	středisko Arcus Praha	Potkani	8	dívčí	-	-	-	-	skautpotkani@gmail.com
Šedé Vlčice	středisko Silmaril Praha	143. oddíl Šedé vlčice	8	dívčí	-	-	-	-	silmaril.holky@seznam.cz
Velrybičky	středisko Hiawatha Praha	Paráda a Vlčáci	5	dívčí	-	-	-	-	suzancatay@seznam.cz,capepi@seznam.cz
Sasanky	středisko Kyje Praha	Amazonky	6	dívčí	-	-	-	-	rusalka.ela@seznam.cz
Sýkorky	středisko STOVKA Praha	148. oddíl skautů a skautek RYS	8	dívčí	-	-	-	-	masimmartin13@gmail.com
Čičinky	18. středisko Kruh Praha	Dívky	5	dívčí	anesticka@gmail.com}.split("\n").each do |line|
    m += 1
    row = line.strip.split("\t")
    t = Team.new
    t.number = m
    t.name = row[0]
    t.initial_emails = row[-1]
    t.district = "#{row[1].strip} | #{row[2].strip}"

    if row[4] == "dívčí"
      t.category = "D"
    elsif row[4] == "chlapecká"
      t.category = "H"
    else
      raise "pizau #{row.inspect}"
    end
    t.save
    t.save
  end
end