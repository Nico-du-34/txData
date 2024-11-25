
// ░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░  ░░░░░██╗░██████╗
// ██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░  ░░░░░██║██╔════╝
// ██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░  ░░░░░██║╚█████╗░
// ██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░  ██╗░░██║░╚═══██╗
// ╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗  ╚█████╔╝██████╔╝
// ░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝  ░╚════╝░╚═════╝░

let Config = []

Config.LockscreenFirstDay = true // if true = Saturday, 22 October, if false = Saturday, October 22 (In app store too).

// Only run this if your country has blocks with YouTube (this disables any sound system, therefore removes spotify or youtube app)
// In this case, you need remove html/js/apps/spotify and html/js/apps/youtube
Config.DisableSounds = false

Config.SmartphoneFPSMeter = false // If you enable this, you will be able to see the Smartphone FPS (ONLY FOR PERFORMANCE TEST!!!!).

Config.DefaultAlbum = 'Album' // This is the prefix for Gallery Albums.

Config.JobsBlockedToContact = [ // Skip this part.
    "police",
    "ambulance",
    "mechanic",
]

// Safari Favorites
Config.SafariFavorite_1 = "https://anhosting.fr/"
Config.SafariFavorite_2 = "https://top-serveurs.net/gta/vote/los-santos-horizon/"
Config.SafariFavorite_3 = "https://www.youtube.com/"
Config.SafariFavorite_4 = "https://www.google.fr/"

// Images routes

// Garage APP
Config.GarageImages = './img/garage/' // Config.GarageImgaes = 'nui://qs-images/html/img/garage_jpg/'
Config.GarageExtension = '.jpg'

// BlackMarket
Config.DarkWebImages = 'img/darkweb_items/' // Config.DarkWebImages = 'nui://qs-images/html/img/BlackMarket/'
Config.DarkWebExtension = '.png'

// Songs that will appear by default in the YouTube App! 
// Some copyrighted videos will not play.
const VideosArray = [
    {
        url: 'https://www.youtube.com/watch?v=3JZ_D3ELwOQ', // "See You Again" - Wiz Khalifa ft. Charlie Puth
    },
    {
        url: 'https://www.youtube.com/watch?v=YQHsXMglC9A', // "Hello" - Adele
    },
    {
        url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // "Never Gonna Give You Up" - Rick Astley
    },
    {
        url: 'https://www.youtube.com/watch?v=9bZkp7q19f0', // "Gangnam Style" - PSY
    },
    {
        url: 'https://www.youtube.com/watch?v=fRh_vgS2dFE', // "Sorry" - Justin Bieber
    },
    {
        url: 'https://www.youtube.com/watch?v=RgKAFK5djSk', // "See You Again" - Wiz Khalifa ft. Charlie Puth (2e)
    },
    {
        url: 'https://www.youtube.com/watch?v=1y6smkh6c-0', // "Don't Let Me Down" - The Chainsmokers ft. Daya
    },
]

// Music and configuration of the Spotify app!
const SpotifyArray = [{ // Don't touch this
    name: 'Chansons aimées',
    description: 'Écoutez votre musique enregistrée et préférée!',
    thumbnail: 'https://t.scdn.co/images/3099b3803ad9496896c43f22fe9be8c4.png',
    playlists: []
}, // Don't touch this until here

    {
        name: 'Rock',
        thumbnail: 'https://www.photolari.com/wp-content/uploads/2019/12/foto-0-portada-nevermind-nirvana.jpg',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=8SbUC-UaAxE' }, // Guns N' Roses - "Sweet Child O' Mine"
            { url: 'https://www.youtube.com/watch?v=djV11Xbc914' }, // Toto - "Africa"
            { url: 'https://www.youtube.com/watch?v=hTWKbfoikeg' }, // Nirvana - "Smells Like Teen Spirit"
            { url: 'https://www.youtube.com/watch?v=QkF3oxziUI4' }, // Aerosmith - "Dream On"
            { url: 'https://www.youtube.com/watch?v=ktvTqknDobU' }, // Imagine Dragons - "Radioactive"
            { url: 'https://www.youtube.com/watch?v=UprcpdwuwCg' }, // Lynyrd Skynyrd - "Sweet Home Alabama"
            { url: 'https://www.youtube.com/watch?v=lcOxhH8N3Bo' }, // Bon Jovi - "Livin' on a Prayer"
            { url: 'https://www.youtube.com/watch?v=wTP2RUD_cL0' }, // Led Zeppelin - "Stairway to Heaven"
            { url: 'https://www.youtube.com/watch?v=fJ9rUzIMcZQ' }, // Queen - "Bohemian Rhapsody"
            { url: 'https://www.youtube.com/watch?v=xtsKUzTiabA' }, // The Police - "Every Breath You Take"
            { url: 'https://www.youtube.com/watch?v=ye5BuYf8q4o' }, // AC/DC - "Highway to Hell"
            { url: 'https://www.youtube.com/watch?v=ujNeHIo7oTE' }, // Guns N' Roses - "Paradise City"
            { url: 'https://www.youtube.com/watch?v=eBG7P-K-r1Y' }, // Foo Fighters - "The Pretender"
            { url: 'https://www.youtube.com/watch?v=OFGgbT_VasI' }, // Eric Clapton - "Layla"
            { url: 'https://www.youtube.com/watch?v=eErdSxFRAm8' }, // Pink Floyd - "Comfortably Numb"
            { url: 'https://www.youtube.com/watch?v=sRYNYb30nxU' }, // Def Leppard - "Pour Some Sugar On Me"
            { url: 'https://www.youtube.com/watch?v=5Jj3wZVc7nw' }, // Scorpions - "Wind of Change"
            { url: 'https://www.youtube.com/watch?v=ZpUYjpKg9KY' }, // Rage Against the Machine - "Killing in the Name"
            { url: 'https://www.youtube.com/watch?v=HgzGwKwLmgM' }, // Queen - "Don't Stop Me Now"
            { url: 'https://www.youtube.com/watch?v=egMWlD3fLJ8' }, // Lynyrd Skynyrd - "Free Bird"
            { url: 'https://www.youtube.com/watch?v=2cZ_EFAmj08' }, // AC/DC - "Back In Black"
            { url: 'https://www.youtube.com/watch?v=B0AxR4oJ65s' }, // Journey - "Don't Stop Believin'"
            { url: 'https://www.youtube.com/watch?v=o1tj2zJ2Wvg' }, // The White Stripes - "Seven Nation Army"
            { url: 'https://www.youtube.com/watch?v=qnkuBUAwfe0' }, // The Rolling Stones - "Paint It Black"
            { url: 'https://www.youtube.com/watch?v=bfFyz53PpZ8' }, // Alice In Chains - "Man in the Box"
            { url: 'https://www.youtube.com/watch?v=ccenFp_3kq8' }, // Deep Purple - "Smoke on the Water"
            { url: 'https://www.youtube.com/watch?v=ed_YKFHfshg' }, // Red Hot Chili Peppers - "Californication"
            { url: 'https://www.youtube.com/watch?v=gp4B1SY4QzY' }, // Boston - "More Than a Feeling"
            { url: 'https://www.youtube.com/watch?v=a6vhxv2oXpA' }, // Black Sabbath - "Paranoid"
            { url: 'https://www.youtube.com/watch?v=XIuYoakC5Zc' }, // Pearl Jam - "Alive"
        ]
    },
    {
        name: 'Jazz',
        thumbnail: 'https://i.discogs.com/YAjlquecpjcTyB32Ps8tocCak_Mbw8XGdpZDFWi_LTQ/rs:fit/g:sm/q:90/h:595/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTQzOTQ4/OC0xMjI2MTYxODEz/LmpwZWc.jpeg',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=71Gt46aX9Z4' }, // Miles Davis - "So What"
            { url: 'https://www.youtube.com/watch?v=bb1SrngIufQ' }, // John Coltrane - "Naima"
            { url: 'https://www.youtube.com/watch?v=H77fRz1rybs' }, // Charles Mingus - "Goodbye Pork Pie Hat"
            { url: 'https://www.youtube.com/watch?v=ioOzsi9aHQQ' }, // Dave Brubeck - "Take Five"
            { url: 'https://www.youtube.com/watch?v=9Pes54J8PVw' }, // Duke Ellington - "In a Sentimental Mood"
            { url: 'https://www.youtube.com/watch?v=SgXSomPE_FY' }, // Chet Baker - "My Funny Valentine"
            { url: 'https://www.youtube.com/watch?v=PAzzDFxu1Uk' }, // Bill Evans - "Waltz for Debby"
            { url: 'https://www.youtube.com/watch?v=xjysvYWYguc' }, // Herbie Hancock - "Cantaloupe Island"
            { url: 'https://www.youtube.com/watch?v=Vf5WtYnNTks' }, // John Coltrane - "Giant Steps"
            { url: 'https://www.youtube.com/watch?v=egX9ZDaIrkU' }, // Louis Armstrong - "What a Wonderful World"
            { url: 'https://www.youtube.com/watch?v=4wu2F5iSrrA' }, // Ella Fitzgerald - "Summertime"
            { url: 'https://www.youtube.com/watch?v=bkUq98qRtlE' }, // Sonny Rollins - "St. Thomas"
            { url: 'https://www.youtube.com/watch?v=kmFk0B0dGy0' }, // Charlie Parker - "Ornithology"
            { url: 'https://www.youtube.com/watch?v=NrJzphD1ZJk' }, // Billie Holiday - "Strange Fruit"
            { url: 'https://www.youtube.com/watch?v=z9QVH8oQGEE' }, // Art Blakey - "Moanin'"
            { url: 'https://www.youtube.com/watch?v=YxhdvQ3WZzY' }, // Miles Davis - "Freddie Freeloader"
            { url: 'https://www.youtube.com/watch?v=yF9AKfknWJw' }, // Dizzy Gillespie - "A Night in Tunisia"
            { url: 'https://www.youtube.com/watch?v=f-cN5m1gfDg' }, // Stan Getz & João Gilberto - "The Girl from Ipanema"
            { url: 'https://www.youtube.com/watch?v=PP8ZgdUE4Xw' }, // Wes Montgomery - "Bumpin' on Sunset"
            { url: 'https://www.youtube.com/watch?v=kY3Nw4absoI' }, // Nina Simone - "Feeling Good"
            { url: 'https://www.youtube.com/watch?v=8B1oIXGX0Io' }, // Charles Mingus - "Haitian Fight Song"
            { url: 'https://www.youtube.com/watch?v=r7-RFQuYhss' }, // Nat King Cole - "L-O-V-E"
            { url: 'https://www.youtube.com/watch?v=rDakci5Z-a8' }, // Oscar Peterson - "Night Train"
            { url: 'https://www.youtube.com/watch?v=V9dIVtoxIyo' }, // Sarah Vaughan - "Misty"
            { url: 'https://www.youtube.com/watch?v=J9GgmGLPbWU' }, // Thelonious Monk - "Round Midnight"
            { url: 'https://www.youtube.com/watch?v=LP_PizKIx_0' }, // Stan Getz - "Desafinado"
            { url: 'https://www.youtube.com/watch?v=mTrZFGeI6kA' }, // Horace Silver - "Song for My Father"
            { url: 'https://www.youtube.com/watch?v=8-oetZIQ78A' }, // Coleman Hawkins - "Body and Soul"
            { url: 'https://www.youtube.com/watch?v=HMnrl0tmd3k' }, // Miles Davis - "Blue in Green"
            { url: 'https://www.youtube.com/watch?v=qP0oCmQ1zCc' }, // John Coltrane - "Equinox"
        ]
    },
    {
        name: 'Chill',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/summer-chillout-cd-cover-artwork-template-design-47093542f55e5139ea7173d1c2261c92_screen.jpg?ts=1589615245',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=JdqL89ZZwFw' }, // ODESZA - "A Moment Apart"
            { url: 'https://www.youtube.com/watch?v=lTRiuFIWV54' }, // Petit Biscuit - "Sunset Lover"
            { url: 'https://www.youtube.com/watch?v=9FvvbVI5rYA' }, // FKJ & Masego - "Tadow"
            { url: 'https://www.youtube.com/watch?v=xocnshwEbrM' }, // Tycho - "Awake"
            { url: 'https://www.youtube.com/watch?v=ROy57arUE1s' }, // Bonobo - "Linked"
            { url: 'https://www.youtube.com/watch?v=QZTDZFtbrec' }, // Emancipator - "Greenland"
            { url: 'https://www.youtube.com/watch?v=pBzZTpmN6h4' }, // Flume - "Holdin On"
            { url: 'https://www.youtube.com/watch?v=0KOEbpLmaWo' }, // Tourist - "We Stayed Up All Night"
            { url: 'https://www.youtube.com/watch?v=5NV6Rdv1a3I' }, // Daft Punk - "Get Lucky" (Chill Mix)
            { url: 'https://www.youtube.com/watch?v=KHF9itPLUo4' }, // Boards of Canada - "Roygbiv"
            { url: 'https://www.youtube.com/watch?v=WQqnIf_9U_U' }, // The xx - "Intro"
            { url: 'https://www.youtube.com/watch?v=OMjF_LLOu14' }, // Massive Attack - "Teardrop"
            { url: 'https://www.youtube.com/watch?v=2ZPI1JP6EUY' }, // Maribou State - "Steal" (ft. Holly Walker)
            { url: 'https://www.youtube.com/watch?v=8GW6sLrK40k' }, // Moby - "Porcelain"
            { url: 'https://www.youtube.com/watch?v=V0PisGe66mY' }, // Air - "La Femme D'Argent"
            { url: 'https://www.youtube.com/watch?v=15dFVLvYtZ0' }, // Tame Impala - "Yes I'm Changing"
            { url: 'https://www.youtube.com/watch?v=y1fZgO_sfxs' }, // Clams Casino - "I'm God"
            { url: 'https://www.youtube.com/watch?v=0l5WrVG-j8g' }, // Chillhop Music - "After Hours"
            { url: 'https://www.youtube.com/watch?v=2MDMb6vTzI8' }, // Tycho - "A Walk"
            { url: 'https://www.youtube.com/watch?v=Hs5xRkG8zeA' }, // HONNE - "Warm on a Cold Night"
            { url: 'https://www.youtube.com/watch?v=rOeU0xjxYzo' }, // Bonobo - "Kerala"
            { url: 'https://www.youtube.com/watch?v=_8dA21KZTkQ' }, // Jamie xx - "Loud Places"
            { url: 'https://www.youtube.com/watch?v=8ss8lPjfag8' }, // Washed Out - "Feel It All Around"
            { url: 'https://www.youtube.com/watch?v=LVkfw8uA2tE' }, // Toro y Moi - "So Many Details"
            { url: 'https://www.youtube.com/watch?v=9iO6_E5uGTE' }, // Poolside - "Harvest Moon"
            { url: 'https://www.youtube.com/watch?v=SQNTayWV2CY' }, // Zero 7 - "In The Waiting Line"
            { url: 'https://www.youtube.com/watch?v=9vMh9f41pqE' }, // Kiasmos - "Looped"
            { url: 'https://www.youtube.com/watch?v=AS_Pk9heXfI' }, // Alina Baraz & Galimatias - "Fantasy"
            { url: 'https://www.youtube.com/watch?v=3ZvmK43E9EM' }, // Bibio - "Lovers' Carvings"
            { url: 'https://www.youtube.com/watch?v=Wln6lNTxVpA' }, // Khruangbin - "White Gloves"
        ]
    },
    {
        name: 'Electronic / Dance',
        thumbnail: 'https://d2n9ha3hrkss16.cloudfront.net/uploads/stage/stage_image/62032/optimized_large_thumb_stage.jpg',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=k3DBmAlUh1A' }, // Avicii - "Levels"
            { url: 'https://www.youtube.com/watch?v=3pL08H3WFrM' }, // Calvin Harris - "Summer"
            { url: 'https://www.youtube.com/watch?v=EfWmWlW2PvM' }, // David Guetta - "Titanium" ft. Sia
            { url: 'https://www.youtube.com/watch?v=3ztSQh7jh_Q' }, // Martin Garrix - "Animals"
            { url: 'https://www.youtube.com/watch?v=BtU2xhK5PZo' }, // The Chainsmokers - "Closer" ft. Halsey
            { url: 'https://www.youtube.com/watch?v=fX0Rj0xgHzI' }, // Major Lazer - "Lean On"
            { url: 'https://www.youtube.com/watch?v=5NV6Rdv1a3I' }, // Daft Punk - "Get Lucky" ft. Pharrell Williams
            { url: 'https://www.youtube.com/watch?v=GqEjdvJf5kU' }, // Kygo - "Firestone" ft. Conrad Sewell
            { url: 'https://www.youtube.com/watch?v=6Mgqbai3fKo' }, // Zedd - "Clarity" ft. Foxes
            { url: 'https://www.youtube.com/watch?v=vjW8wmF5VWc' }, // Calvin Harris - "Feel So Close"
            { url: 'https://www.youtube.com/watch?v=9vMh9f41pqE' }, // Avicii - "Wake Me Up"
            { url: 'https://www.youtube.com/watch?v=KdxEAt91D7k' }, // Deadmau5 - "Strobe"
            { url: 'https://www.youtube.com/watch?v=_ovdm2yX4MA' }, // Skrillex - "Bangarang"
            { url: 'https://www.youtube.com/watch?v=tDg5N3O6wiE' }, // Swedish House Mafia - "Don't You Worry Child"
            { url: 'https://www.youtube.com/watch?v=jMlDnxA5mt8' }, // Tiësto - "Red Lights"
            { url: 'https://www.youtube.com/watch?v=ZyhrYis509A' }, // Eiffel 65 - "Blue (Da Ba Dee)"
            { url: 'https://www.youtube.com/watch?v=lTRiuFIWV54' }, // Petit Biscuit - "Sunset Lover"
            { url: 'https://www.youtube.com/watch?v=xpD_CfEAfgE' }, // Eric Prydz - "Call on Me"
            { url: 'https://www.youtube.com/watch?v=xsop0MFttS0' }, // Disclosure - "Latch" ft. Sam Smith
            { url: 'https://www.youtube.com/watch?v=CduA0TULnow' }, // Justin Bieber - "Sorry" (Dance Version)
            { url: 'https://www.youtube.com/watch?v=nfWlot6h_JM' }, // Maroon 5 - "Sugar"
            { url: 'https://www.youtube.com/watch?v=60ItHLz5WEA' }, // Alan Walker - "Faded"
            { url: 'https://www.youtube.com/watch?v=IcrbM1l_BoI' }, // Calvin Harris - "This Is What You Came For"
            { url: 'https://www.youtube.com/watch?v=r3y0RO6i61A' }, // Clean Bandit - "Rather Be" ft. Jess Glynne
            { url: 'https://www.youtube.com/watch?v=f7PzkD_eKgE' }, // Armin van Buuren - "Blah Blah Blah"
            { url: 'https://www.youtube.com/watch?v=SBClImpnfAg' }, // Benny Benassi - "Satisfaction"
            { url: 'https://www.youtube.com/watch?v=8N7_rqEmhVk' }, // Flume - "Never Be Like You" ft. Kai
            { url: 'https://www.youtube.com/watch?v=k-d7NDdB_m4' }, // R3HAB & Amba Shepherd - "Smells Like Teen Spirit"
            { url: 'https://www.youtube.com/watch?v=n_NdI8BdsX8' }, // Marshmello - "Alone"
            { url: 'https://www.youtube.com/watch?v=MYzcmODZEpM' }, // Robin Schulz - "Sugar" ft. Francesco Yates
            { url: 'https://www.youtube.com/watch?v=XX3Izcrlk_Q' }, // Joel Corry - "Head & Heart" ft. MNEK
        ]
    },
    {
        name: 'Metal',
        thumbnail: 'https://www.revolvermag.com/sites/default/files/styles/original_image__844px_x_473px_/public/media/section-media/81hryxavzjl._sl1425_.jpg?itok=bjKLgbqe&timestamp=1559146162',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=l9VFg44H2z8' }, // Metallica - "Enter Sandman"
            { url: 'https://www.youtube.com/watch?v=AkFqg5wAuFk' }, // Guns N' Roses - "Sweet Child O' Mine"
            { url: 'https://www.youtube.com/watch?v=CSvFpBOe8eY' }, // System Of A Down - "Chop Suey!"
            { url: 'https://www.youtube.com/watch?v=6fVE8kSM43I' }, // Avenged Sevenfold - "Hail to the King"
            { url: 'https://www.youtube.com/watch?v=DelhLppPSxY' }, // Disturbed - "Down with the Sickness"
            { url: 'https://www.youtube.com/watch?v=5abamRO41fE' }, // Iron Maiden - "The Trooper"
            { url: 'https://www.youtube.com/watch?v=3mbvWn1EY6g' }, // Slayer - "Raining Blood"
            { url: 'https://www.youtube.com/watch?v=WxnN05vOuSM' }, // Ozzy Osbourne - "Crazy Train"
            { url: 'https://www.youtube.com/watch?v=jUkoL9RE72o' }, // Slipknot - "Duality"
            { url: 'https://www.youtube.com/watch?v=WxnN05vOuSM' }, // Judas Priest - "Painkiller"
            { url: 'https://www.youtube.com/watch?v=dscfeQOMuGw' }, // Pantera - "Walk"
            { url: 'https://www.youtube.com/watch?v=3dLq7FfhnjU' }, // Megadeth - "Holy Wars... The Punishment Due"
            { url: 'https://www.youtube.com/watch?v=hTWKbfoikeg' }, // Nirvana - "Smells Like Teen Spirit" (Hard Rock Influence)
            { url: 'https://www.youtube.com/watch?v=jpYwE3NgI2Y' }, // Killswitch Engage - "My Curse"
            { url: 'https://www.youtube.com/watch?v=LatorN4P9aA' }, // Metallica - "Master of Puppets"
            { url: 'https://www.youtube.com/watch?v=5s7_WbiR79E' }, // Tool - "Schism"
            { url: 'https://www.youtube.com/watch?v=sXdKlpBOvs0' }, // Sepultura - "Roots Bloody Roots"
            { url: 'https://www.youtube.com/watch?v=eMqsWc8muj8' }, // Korn - "Freak on a Leash"
            { url: 'https://www.youtube.com/watch?v=XmZ5dKjxpaE' }, // Black Sabbath - "War Pigs"
            { url: 'https://www.youtube.com/watch?v=0ODDtLMiGnY' }, // Arch Enemy - "Nemesis"
            { url: 'https://www.youtube.com/watch?v=og5dE1HnCfQ' }, // Lamb of God - "Redneck"
            { url: 'https://www.youtube.com/watch?v=4Gv5GVYoH8o' }, // Motörhead - "Ace of Spades"
            { url: 'https://www.youtube.com/watch?v=kGE7VDhxqes' }, // Dream Theater - "Pull Me Under"
            { url: 'https://www.youtube.com/watch?v=p4OosXNug38' }, // Gojira - "Stranded"
            { url: 'https://www.youtube.com/watch?v=gEPmA3USJdI' }, // AC/DC - "Thunderstruck"
            { url: 'https://www.youtube.com/watch?v=uVaHG_QMvNk' }, // Mastodon - "Blood and Thunder"
            { url: 'https://www.youtube.com/watch?v=8pMTPG5TtB0' }, // Trivium - "In Waves"
            { url: 'https://www.youtube.com/watch?v=RtMGoU9NcMo' }, // Anthrax - "Caught in a Mosh"
            { url: 'https://www.youtube.com/watch?v=FmrXYcsiRPs' }, // Children of Bodom - "Are You Dead Yet?"
            { url: 'https://www.youtube.com/watch?v=8WWp67DsTk4' }, // Behemoth - "O Father O Satan O Sun!"
        ]
    },
    {
        name: 'Hip Hop',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/hip-hop-modern-album-cover-video-design-template-feff1ee7028b6c491f3382b8b8932c11_screen.jpg?ts=1649518691',
        playlists: [
            { url: 'https://www.youtube.com/watch?v=-jEShhcnxIM' }, // Tupac - "California Love"
            { url: 'https://www.youtube.com/watch?v=hpK16l6fDsg' }, // The Notorious B.I.G. - "Juicy"
            { url: 'https://www.youtube.com/watch?v=NSCZ5awmH1U' }, // Nas - "N.Y. State of Mind"
            { url: 'https://www.youtube.com/watch?v=Xrk6JQNqM0g' }, // Wu-Tang Clan - "C.R.E.A.M."
            { url: 'https://www.youtube.com/watch?v=kC8YEw9h2-Q' }, // Dr. Dre - "Still D.R.E." ft. Snoop Dogg
            { url: 'https://www.youtube.com/watch?v=9dosj6p1DqY' }, // Jay-Z - "99 Problems"
            { url: 'https://www.youtube.com/watch?v=LuKm4L9ryB0' }, // Kendrick Lamar - "HUMBLE."
            { url: 'https://www.youtube.com/watch?v=IAJnDmMN5VU' }, // J. Cole - "No Role Modelz"
            { url: 'https://www.youtube.com/watch?v=krV1i_FzyNU' }, // Eminem - "Lose Yourself"
            { url: 'https://www.youtube.com/watch?v=UceaB4D0jpo' }, // Kanye West - "Stronger"
            { url: 'https://www.youtube.com/watch?v=VC-bYJmGv60' }, // OutKast - "Ms. Jackson"
            { url: 'https://www.youtube.com/watch?v=0eTjMNV__5M' }, // 50 Cent - "In Da Club"
            { url: 'https://www.youtube.com/watch?v=qfbCML6Igwc' }, // Snoop Dogg - "Gin and Juice"
            { url: 'https://www.youtube.com/watch?v=4I1yYNhAwhg' }, // A Tribe Called Quest - "Can I Kick It?"
            { url: 'https://www.youtube.com/watch?v=IsQFg4OA3ng' }, // DMX - "X Gon' Give It To Ya"
            { url: 'https://www.youtube.com/watch?v=1PLhYeWuqe4' }, // Run-D.M.C. - "It's Tricky"
            { url: 'https://www.youtube.com/watch?v=y_JoZ_kaOeQ' }, // Cardi B - "Bodak Yellow"
            { url: 'https://www.youtube.com/watch?v=d7g4IJVY-b0' }, // Travis Scott - "SICKO MODE"
            { url: 'https://www.youtube.com/watch?v=UePtoxDhJSw' }, // Lil Wayne - "A Milli"
            { url: 'https://www.youtube.com/watch?v=otCpCn0l4Wo' }, // MC Hammer - "U Can't Touch This"
            { url: 'https://www.youtube.com/watch?v=QUZCJpprhXU' }, // Public Enemy - "Fight The Power"
            { url: 'https://www.youtube.com/watch?v=5J1tw1g3mBU' }, // Ice Cube - "It Was A Good Day"
            { url: 'https://www.youtube.com/watch?v=HfXwmDGJAB8' }, // N.W.A - "Straight Outta Compton"
            { url: 'https://www.youtube.com/watch?v=_L2vJEb6lVE' }, // 2Pac - "Changes"
            { url: 'https://www.youtube.com/watch?v=z8Gf3mC6oHc' }, // Missy Elliott - "Get Ur Freak On"
            { url: 'https://www.youtube.com/watch?v=eFTLKWw542g' }, // Sugarhill Gang - "Rapper's Delight"
            { url: 'https://www.youtube.com/watch?v=N-AOe2tE-Ts' }, // Megan Thee Stallion - "Savage"
            { url: 'https://www.youtube.com/watch?v=jTqEyfIf4tk' }, // Migos - "Bad and Boujee" ft. Lil Uzi Vert
            { url: 'https://www.youtube.com/watch?v=otCqbnYV8E0' }, // Rakim - "Paid in Full"
            { url: 'https://www.youtube.com/watch?v=3KL9mRus19o' }, // Nas - "If I Ruled The World" ft. Lauryn Hill
        ]
    }
]

Config.ConnectionBypassApps = [ // Applications that you can open without a telephone signal.
    "settings",
    "help",
    "weather",
    "notes",
    "camera",
    "photos",
    "clock",
    "jump",
    "calculator",
    "meos",
    "flappy",
    "kong",
]

// Don't touch this, it won't make any changes.
Config.HeaderDisabledApps = [
    "bank",
    "whatsapp",
    "meos",
    "garage",
    "racing",
    "lawyers",
    "youtube",
]

// Weather translations for your widget.
function WeatherTranslation(x) {
    if (x == "RAIN") { x = "Pluie" }
    else if (x == "THUNDER") { x = "Orage" }
    else if (x == "CLEARING") { x = "Éclaircie" }
    else if (x == "CLEAR") { x = "Clair" }
    else if (x == "EXTRASUNNY") { x = "Très ensoleillé" }
    else if (x == "CLOUDS") { x = "Nuageux" }
    else if (x == "OVERCAST") { x = "Couvert" }
    else if (x == "SMOG") { x = "Smog" }
    else if (x == "FOGGY") { x = "Brumeux" }
    else if (x == "XMAS") { x = "Noël" }
    else if (x == "SNOWLIGHT") { x = "Légère neige" }
    else if (x == "BLIZZARD") { x = "Tempête de neige" }
    else if (x == "BILINMIYOR") { x = "Autre" } else { x = "Autre" }
    return x
}

// Dates of your phone.
Config.January = "Janvier"
Config.February = "Février"
Config.March = "Mars"
Config.April = "Avril"
Config.May = "Mai"
Config.June = "Juin"
Config.July = "Juillet"
Config.August = "Août"
Config.September = "Septembre"
Config.October = "Octobre"
Config.November = "Novembre"
Config.December = "Décembre"

Config.Jan = "Janv"
Config.Feb = "Fév"
Config.Mar = "Mars"
Config.Apr = "Avr"
Config.May = "Mai"
Config.Jun = "Juin"
Config.Jul = "Juil"
Config.Aug = "Août"
Config.Sept = "Sept"
Config.Oct = "Oct"
Config.Nov = "Nov"
Config.Dec = "Déc"

Config.Sunday = "Dimanche"
Config.Monday = "Lundi"
Config.Tuesday = "Mardi"
Config.Wednesday = "Mercredi"
Config.Thursday = "Jeudi"
Config.Friday = "Vendredi"
Config.Saturday = "Samedi"

Config.Everyday = "Tous les jours"
Config.Weekend = "Week-end"
Config.Weekdays = "Jours de semaine"

// App state, remember to edit the html too.
Config.Job1 = "police" // Default "police"
Config.Job2 = "ambulance" // Default "ambulance"
Config.Job3 = "realestate" // Default "realestate"
Config.Job4 = "taxi" // Default "taxi"

// Color of the header and home-bar of each application.
Config.HeaderColors = {
    "image-zoom": {
        "top": "#000000",
        "bottom": "#FFFFFF"
    },
    "phone": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "photos": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "messages": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "settings": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "clock": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "camera": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "mail": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "bank": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weather": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "notes": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calendar": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "calculator": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "store": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "ping": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tiktok": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "spotify": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "business": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "safari": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "advert": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "garage": {
        "top": "#FFFFFF",
        "bottom": "#000000"
    },
    "group-chats": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "instagram": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tips": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "meos": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "state": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "tinder": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "twitter": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uber": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "uberDriver": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "weazel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "whatsapp": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "youtube": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "darkchat": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "darkweb": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "phone-call": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "rentel": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "racing": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "flappy": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "jump": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "kong": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "tower": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "labyrinth": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "crypto": {
        "top": "#FFFFFF",
        "bottom": "#FFFFFF"
    },
    "radio": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "sellix": {
        "top": "#000000",
        "bottom": "#000000"
    },
    "example": {
        "top": "#000000",
        "bottom": "#000000"
    },
}