var app = new Vue({
    el: "#app",
    data: {
      leaderboard:[
      ],

      playerLoc: false,
    },
    mounted: function(){
       console.warn("Leaderboard iniciated.")

       // this.repositioning()
       this.init()

    },
    methods: {
        init(){
            this.leaderboard = this.leaderboard.sort((a, b) => parseFloat(a.pos) - parseFloat(b.pos));
            for(k = 0; k < this.leaderboard.length; k++){
                if(this.leaderboard[k].id == -1 && this.leaderboard[k].pos >=5){
                    this.playerLoc = true;
                }else if(this.leaderboard[k].id == -1 && this.leaderboard[k].pos <= 4){
                    this.playerLoc = false;
                }
            }
        },
    }
})

window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {
        case 'updateLeaderboard':
            app.leaderboard = data.leaderboard;
            app.init()
            break;
	}
})

