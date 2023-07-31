local Jon_Entry = 9563 

local function Jon_GossipHello(event, player, unit)
    player:GossipClearMenu()
    
    if player:HasQuest(4224) then
        player:GossipMenuAddItem(0, "Official business, John. I need some information about Marshal Windsor. Tell me about the last time you saw him.", 0, 1)
        player:GossipSendMenu(2713, unit)
    else
        player:GossipAddQuests(unit)
        player:GossipSendMenu(2713, unit)
    end
end

local function Jon_GossipSelect(event, player, unit, sender, intid, code)
    player:GossipClearMenu()
    local playerName = player:GetName()
    local address = player:GetGender() == 0 and "Mister" or "Missy"

    if (intid == 1) then
        unit:SendUnitSay("Windsor was particularly ornery that day - and believe me, for Windsor, that's a monumental accomplishment. He kept telling me that 'something feels off.' Well, he wasn't kidding! We were in the middle of Blackrock Mountain when the filthy animals attacked. I'm talking about the orcs, of course. Pay attention, will ya? All you could hear were the grunts and the clanging of steel as they rushed us.", 0)
        player:GossipMenuAddItem(0, "So what did you do?", 0, 2)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 2) then
        unit:SendUnitSay("Me versus fifty orcs? I'm no fool, " .. playerName .. ". My pappy always told me, 'Discretion is the better part of valor,' or something, and I knew what that meant.", 0)
        player:GossipMenuAddItem(0, "Start making sense, dwarf. I don't want to have anything to do with your cracker, your pappy, or any sort of 'discreditin'.", 0, 3)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 3) then
        unit:SendUnitSay("Alright, alright. Anyhow, so I sorta slipped into the shadows. That didn't sit too well with Windsor, seeing as how he was already extra cranky. Well he started spinnin' old Ironfoe around and screaming like a mad man at the orcs.", 0)
        player:GossipMenuAddItem(0, "Ironfoe?", 0, 4)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 4) then
        unit:SendUnitSay("Yep. You never heard of Ironfoe? The legendary orc slaying hammer? Yep, yep, that was ol' Windsor's hammer. He told me that Franclorn Forgewright himself made that hammer for his great, great, grand pappy. THE Franclorn Forgewright. The Dark Iron responsible for stonewrought architecture... building stuff. He also said the hammer had a twin that Franclorn kept for himself. Think he called it Ironfel or something.", 0)
        player:GossipMenuAddItem(0, "Interesting... continue, John.", 0, 5)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 5) then
        unit:SendUnitSay("So where was I? Oh yea, so the orcs rushed Windsor and Windsor? Well, he didn't move an inch. He stood tall as they charged him, ten at a time. All I could see was the glow from Ironfoe and a lot of blood. This went on for hours, maybe days. I don't remember. Anyhow, FINALLY, it stopped.", 0)
        player:GossipMenuAddItem(0, "So that's how Windsor died...", 0, 6)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 6) then
        unit:SendUnitSay("Died? Are you cracked, " .. playerName .. "? Excuse me, " .. address .. " " .. playerName .. "! Windsor wouldn't have died from no fifty orcs. As sure as Thelsamar blood sausage is the tastiest food the world may ever know, there he stood: he was covered in orc chunks from head to toe, drenched in about eighteen layers of their blood, but he was definitely alive... and really, really angry.", 0)
        player:GossipMenuAddItem(0, "So how did he die?", 0, 7)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 7) then
        unit:SendUnitSay("Why do you keep saying he died? Who told you he died? I never said he died. He went missing is all. You see, apparently we had gotten into the middle of some big orc versus Dark Iron dwarf battle. The orcs, being the filthy miserable curs that they are, were out early, setting up some traps and other diabolical things you probably wouldn't understand.", 0)
        player:GossipMenuAddItem(0, "Ok, so where the hell is he? Wait a minute! Are you drunk?", 0, 8)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 8) then
        unit:SendUnitSay("Dwarves don't get drunk, " .. address .. ". I'm just a little sloppy. Anyhow, Windsor? I figure he's somewhere in the Blackrock Depths. That's the Dark Iron City for you uneducated peoples.", 0)
        player:GossipMenuAddItem(0, "WHY is he in Blackrock Depths?", 0, 9)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 9) then
        unit:SendUnitSay("Slow down! I was getting to that! So there he was, standing tall with all the blood and guts dripping off him when who shows up? The Dark Irons! Didn't you hear a word I said?? Well, the Dark Irons are a little craftier than those Blackrock Orcs. They came prepared. By prepared I mean there were about 300 of em... *hic* 'scuse me.", 0)
        player:GossipMenuAddItem(0, "300? So the Dark Irons killed him and dragged him into the Depths?", 0, 10)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 10) then
        unit:SendUnitSay(address .. ", if I didn't know better, I'd think you were one of those 'special' peoples. We call 'em Troggs. Windsor didn't have no beef with the Dark Irons, after all, his great, great, grand pappy's best friend was a Dark Iron. Which is also probably why that army of Dark Irons didn't kill him on sight.", 0)
        player:GossipMenuAddItem(0, "Ahhh... Ironfoe.", 0, 11)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 11) then
        unit:SendUnitSay("Finally! Put some fingers in your ears, your brain mighta just grown five sizes and I'm worried it might leak out. So the Dark Irons spared his life and took him prisoner. Their leader, some self-important, took Ironfoe for himself. And that was the last I saw of ol' Windsor... *hic* 'scuse me.", 0)
        player:GossipMenuAddItem(0, "Thanks, Ragged John. Your story was very uplifting and informative.", 0, 12)
        player:GossipSendMenu(2713, unit)
    elseif (intid == 12) then
        unit:SendUnitSay("You're welcome! If you need any more stories or a swig of ale, you know where to find me!", 0)
        player:CompleteQuest(4224)
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(Jon_Entry, 1, Jon_GossipHello)
RegisterCreatureGossipEvent(Jon_Entry, 2, Jon_GossipSelect)
