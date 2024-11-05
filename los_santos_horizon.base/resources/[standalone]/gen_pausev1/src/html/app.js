const app = Vue.createApp({
    data: () => ({     
        general: {
            server : "GEN",
            show : false,
            online : 150,
            total : 512,
        },

        player : {
            name : 'Kerem U.',
            job : 'Mechanic',
            grade : 'Master',
            birthdate : '10/10/1990',
            totaltime : '10 d. 20 h. 10 m.',
            gender : 'Male',
            steam : 'Kerem U.',
            bank : 0,
            wallet : 0,
            steamprofile : 'https://cdn.discordapp.com/attachments/1072700165581971529/1220860465455038605/Gen_Mavi.png?ex=661079e9&is=65fe04e9&hm=a0ab58a976b0f695c1bcd97a16558270f700182c99c2600a83903062a48ceaa5&',
        },

        locales: false,

        table : [
            { title : 'Announce Detail', date : '11.05.2024', text : 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc. Sollicitudin viverra tristique metus cras faucibus at sodales a maecenas. Convallis arcu convallis libero vulputate tempus amet metus.', },
            { title : 'Announce Detail', date : '11.05.2024', text : 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc. Sollicitudin viverra tristique metus cras faucibus at sodales a maecenas. Convallis arcu convallis libero vulputate tempus amet metus.', },
            { title : 'Announce Detail', date : '11.05.2024', text : 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc. Sollicitudin viverra tristique metus cras faucibus at sodales a maecenas. Convallis arcu convallis libero vulputate tempus amet metus.', },
            { title : 'Announce Detail', date : '11.05.2024', text : 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc. Sollicitudin viverra tristique metus cras faucibus at sodales a maecenas. Convallis arcu convallis libero vulputate tempus amet metus.', },
            { title : 'Announce Detail', date : '11.05.2024', text : 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc. Sollicitudin viverra tristique metus cras faucibus at sodales a maecenas. Convallis arcu convallis libero vulputate tempus amet metus.', },
        ],

        
        anim : {
            menu: [1, 2, 3, 4, 5],
        },

    }), 

    methods: {
        setMenu(menu) {
            if (this.general.menu == menu) {
                this.general.menu = false;
            } else {
                this.general.menu = menu;
            }
        },
        setFont(family, style, weight, size, height) {
            return {
                fontFamily: family,
                fontStyle: style,
                fontWeight: weight,
                fontSize: size,
                lineHeight: height,                
            };
        },
        setTextLinear(bg) {
            return {
              background: bg,
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip : 'text',
            };
        }, 
        setMap() {
            postNUI('setMap')
            this.general.show = false;
        },
        setSettings() {
            postNUI('setSettings')
            this.general.show = false;
        },
        animateMenu() {
            this.anim.menu.forEach((Get, Index) => {
                const MenuID = 'menu-' + Index;
                anime({
                    targets: '#' + MenuID,
                    opacity: [0, 1], 
                    scale : [0.7, 1],
                    duration: 1500,
                    delay: 150 * Index,
                    easing: 'easeOutCubic',
                    translateX: [-350, 0],
                });
            });

            anime({
                targets: '#mans',
                opacity: [0, 1], 
                duration: 2000,
                easing: 'easeOutCubic',
                translateX: [900, 0],
            });
        },        
        keyHandler(e)  {
            
        },  
    },
    computed: {    
        
    },
    mounted() {
        window.addEventListener("message", event => {
            const { action, data } = event.data;
            if (action == 'setThis') {                
                this.locales = data.locales;
                this.table = data.announce;
                this.general.server = data.serverName;
            } else if (action == 'setData') {  
                this.player.wallet = data.moneyCash;
                this.player.bank = data.moneyBank;
                this.player.job = data.job;
                this.player.grade = data.grade;
                this.player.gender = data.gender;
                this.player.birthdate = data.birthdate;
                this.player.name = data.firstname + " " + data.lastname;

                this.player.steam = data.steam;

                this.player.totaltime = data.currentPlayTime;

                this.general.total = data.maxPlayers;
                this.general.online = data.connectedPlayers;

                if (data.steamid) { 

                    var xhr = new XMLHttpRequest();
                    xhr.responseType = "text";
                    xhr.open("GET", data.steamid, true);
                    xhr.onreadystatechange = processRequest.bind(this);
                    xhr.send();
                    
                    function processRequest(e) {
                        if (xhr.readyState == 4 && xhr.status == 200) {
                            var string = xhr.responseText.toString();
                            var array = string.split("avatarfull");
                            var array2 = array[1].toString().split('"');
                            var profilePhoto = array2[2].toString();
                    
                            if (xhr.status === 200) {
                                this.player.steamprofile = profilePhoto;
                            }
                        }
                    }

                } else if (data.avatar) {  
                    
                    this.player.steamprofile = data.avatar;
                }
                
                function processRequest(e) {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var string = xhr.responseText.toString();
                        var array = string.split("avatarfull");
                        var array2 = array[1].toString().split('"');
                        var profilePhoto = array2[2].toString();
                
                        if (xhr.status === 200) {
                            this.player.steamprofile = profilePhoto;
                        }
                    }
                }

                this.general.show = true;

                setTimeout(() => {
                    this.animateMenu();
                }, 10);

            } else if (action == 'setShow') {  

                this.general.show = data.value;

            }   
        });
    }
    
});

app.mount("#app");

$(document).on("keydown", function () {
    switch (event.keyCode) {
        case 27:
            postNUI('close')
            break;
    }
});

var resourceName = "gen_pausev1";

if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = (name, data, callback) => {
    fetch(`https://${resourceName}/${name}`, {
        method: "POST",
        mode: "cors",
        cache: "no-cache",
        credentials: "same-origin",
        headers: {
            "Content-Type": "application/json"
        },
        redirect: "follow",
        referrerPolicy: "no-referrer",
        body: JSON.stringify(data)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Network response was not ok, status: ${response.status}`);
        }
        return response.json();
    })
    .then(responseData => {
        if (callback && typeof callback === "function") {
            callback(responseData);
        }
    })
};