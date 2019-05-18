task :build_teams => :environment do
  Team.destroy_all
  m = 0
  %{Jezevci	středisko Polaris Praha	Práčata	8	chlapecká	-	-	-	-	
Albatrosové	4. přístav Jana Nerudy Praha	Albatrosové	8	chlapecká	-	-	-	-	
Horníci z Dejvic	18. středisko Kruh Praha	Chlapci	6	chlapecká	-	-	-	-	
Káňata	34. středisko Ostříž Praha	145. oddíl skautů "Naděje"	7	chlapecká	-	-	-	-	
Střelci	7. středisko Blaník Praha	Černý šíp	5	chlapecká	-	-	-	-	
Sloni	středisko Oheň Horní Počernice	92. oddíl skautů Vatra	4	chlapecká	-	-	-	-	
Bro	středisko Stopaři Praha	Bronco	6	chlapecká	-	-	-	-	
Šupáci	středisko Pplk. Vally Praha	107.skautský oddíl AVALON	4	chlapecká	-	-	-	-	
Krakeni	středisko Maják Praha	Ignis	7	chlapecká	-	-	-	-	
Omega	středisko 24 Sever Praha	24. oddíl skautů Orionis	4	chlapecká	-	-	-	-	
Šarlatoví beránci	středisko 55 Vatra Praha	96.oddíl Šipka	6	chlapecká	-	-	-	-	
Svišti	středisko STOVKA Praha	148. oddíl skautů a skautek RYS	6	chlapecká	-	-	-	-	
Blbouni	středisko Bílý los Praha	Ztracená Hvězda	6	dívčí	-	-	-	-	
Vážky	středisko Bílý Albatros Praha	Argyroneta	5	dívčí	-	-	-	-	
Squaw	7. středisko Blaník Praha	Říčany	5	dívčí	-	-	-	-	
Včely	středisko Hiawatha Praha	Minnehaha	8	dívčí	-	-	-	-	
Panteři	středisko Bílý los Praha	Ztracená Hvězda	6	dívčí	-	-	-	-	
Vlaštovky	středisko 24 Sever Praha	24.oddíl skautek	7	dívčí	-	-	-	-	
Vidlačky	středisko Oheň Horní Počernice	92.oddíl skautek - Vlnky	7	dívčí	-	-	-	-	
DĚBENKY beta	přístav Pětka Praha	Děbenky	5	dívčí	-	-	-	-	
Potkani	středisko Arcus Praha	Potkani	8	dívčí	-	-	-	-	
Šedé Vlčice	středisko Silmaril Praha	143. oddíl Šedé vlčice	8	dívčí	-	-	-	-	
Velrybičky	středisko Hiawatha Praha	Paráda a Vlčáci	5	dívčí	-	-	-	-	
Sasanky	středisko Kyje Praha	Amazonky	6	dívčí	-	-	-	-	
Sýkorky	středisko STOVKA Praha	148. oddíl skautů a skautek RYS	8	dívčí	-	-	-	-	
Čičinky	18. středisko Kruh Praha	Dívky	5	dívčí}.split("\n").each do |line|
    m += 1
    row = line.strip.split("\t")
    t = Team.new
    t.number = m
    t.name = row[0]
    t.district = "#{row[1].strip} | #{row[2].strip}"

    if row[4] == "dívčí"
      t.category = "D"
    elsif row[4] == "chlapecká"
      t.category = "H"
    else
      raise "pizau #{row.inspect}"
    end 
    t.save
  end
end