const Config = {}

Config.LockScreenTransitionTime = 450;
Config.LockScreenTransitionType = 'easeOutQuad';

Config.RTCServers = {
    iceServers: [
        {
            urls: "stun:stun.l.google.com:19302"
        },
        {
            urls: ["turn:eu-0.turn.peerjs.com:3478", "turn:us-0.turn.peerjs.com:3478"],
            username: "peerjs", credential: "peerjsp"
        }
    ],
    sdpSemantics: "unified-plan"

}

Config.Widgets = [
    {
        name: "weazel-widget",
        scale: 4,
    },
    {
        name: "weather-widget",
        scale: 4
    },
    {
        name: "battery-widget",
        scale: 4
    },
    {
        name: "calendar-widget",
        scale: 4
    },
    {
        name: "spotify-widget",
        scale: 8
    },
    {
        name: "reminder-widget",
        scale: 4
    },
    {
        name: "notes-widget",
        scale: 4
    },
    {
        name: 'gallery-widget',
        scale: 8
    },
    {
        name: 'map-widget',
        scale: 4
    },
    {
        name: 'crypto-widget',
        scale: 4
    }
];

Config.lockScreenWidgets = [
    {
        name: 'battery',
        scale: 1
    },
    {
        name: 'rain',
        scale: 1
    },
    {
        name: 'reminder',
        scale: 2
    },
    {
        name: 'weazel',
        scale: 2
    },
    {
        name: 'weather',
        scale: 2
    }
];

Config.StateJobColors = new Map([
    ['default', '#7623c9'],
    ['police', '#1e90ff'],
]);

Config.ScaleMultiplier = 0.65

Config.ByPassSqlInjectionAndCheats = [
    'SELECT * FROM users WHERE username = ',
    'script',
    'alert',
    'prompt',
    'eval',
    'document',
    'window',
    'location',
    'location.href',
    'location.assign',
    'location.replace',
    'location.reload',
    'location.reload()'
];

Config.DefaultBackground = "b2.jpg"

Config.Backgrounds = new Map([
    ['b1.jpg', 'Titanium white'],
    ['b2.jpg', 'Titanium gray'],
    ['b3.jpg', 'Titanium brown'],
    ['b4.jpg', 'Titanium black'],
    ['b5.jpg', 'Titanium Spacial'],
    ['b6.jpg', 'Titanium lila'],
    ['b7.jpg', 'Bubbles white'],
    ['b8.jpg', 'Bubbles blue'],
    ['b9.jpg', 'Bubbles lila'],
    ['b10.jpg', 'Bubbles pink'],
    ['b11.jpg', 'Bubbles green'],
    ['b12.jpg', 'Bubbles blur'],
    ['b13.jpg', 'Shock violet'],
    ['b14.jpg', 'Shock blue'],
    ['b15.jpg', 'Shock mix'],
    ['b16.jpg', 'Shock brown'],
    ['b17.jpg', 'Neon blue'],
    ['b18.jpg', 'Neon pink'],
    ['b19.jpg', 'Uniform violet'],
    ['b20.jpg', 'Uniform green'],
    ['b21.jpg', 'Uniform pink'],
    ['b22.jpg', 'Uniform red'],
    ['b23.jpg', 'Uniform blue'],
    ['b24.jpg', 'Uniform mixed'],
    ['b25.jpg', 'Planet orange'],
    ['b26.jpg', 'Planet light'],
]);

Config.DarkModeApplications = new Map([
    ['camera', true],
    ['phone-call', true],
    ['spotify', true],
    ['calculator', true],
    ['crypto', true],
    ['weather', true],
    ['clock', true],
    ['garage', true],
    ['jobcenter', true],
    ['houses', true],
    ['darkchat', true],
    ['discord', true],
    ['darkweb', true],
    ['racing', true],
    ['safari', true],
    ['kingkongracing', true]
]);

Config.WorkWithWifiApps = new Map([
    ["settings", true],
    ["help", true],
    ["notes", true],
    ["camera", true],
    ["gallery", true],
    ["clock", true],
    ["jump", true],
    ["tetris", true]
])

Config.VideosArray = [
    {
        url: 'https://www.youtube.com/watch?v=3datr3PTN2A',
    },
    {
        url: 'https://www.youtube.com/watch?v=gHgv19ip-0c'
    },
    {
        url: 'https://www.youtube.com/watch?v=CJnaPlgMn5c'
    },
    {
        url: 'https://www.youtube.com/watch?v=yUXJjIvhZz8'
    },
    {
        url: 'https://www.youtube.com/watch?v=tIxLU8WUK1Y'
    },
    {
        url: 'https://www.youtube.com/watch?v=b35RwruI8Vk'
    },
    {
        url: 'https://www.youtube.com/watch?v=Q9yn1DpZkHQ'
    },
    {
        url: 'https://www.youtube.com/watch?v=A-YlFaYVmBA'
    },
    {
        url: 'https://www.youtube.com/watch?v=Jm932Sqwf5E'
    },
    {
        url: 'https://www.youtube.com/watch?v=cUbri6sSgK4'
    },
    {
        url: 'https://www.youtube.com/watch?v=dh01eSOn9_E'
    },
    {
        url: 'https://www.youtube.com/watch?v=J0y6wM0aAgE'
    },
    {
        url: 'https://www.youtube.com/watch?v=TGRD0fJh1_Y'
    },
    {
        url: 'https://www.youtube.com/watch?v=JXq2TBAuL8o'
    },
    {
        url: 'https://www.youtube.com/watch?v=gM4xZy39kNE'
    },
    {
        url: 'https://www.youtube.com/watch?v=0fora21hSSU'
    },
    {
        url: 'https://www.youtube.com/watch?v=zcbOfVKSMkA'
    },
    {
        url: 'https://www.youtube.com/watch?v=fHhLUiRfpY4'
    },
    {
        url: 'https://www.youtube.com/watch?v=I5SkOMXLpi0'
    },
    {
        url: 'https://www.youtube.com/watch?v=KqTGdXfNmA8'
    },
];

Config.SpotifyDefaultPlaylists = [
    {
        name: 'Rock',
        thumbnail: 'https://www.photolari.com/wp-content/uploads/2019/12/foto-0-portada-nevermind-nirvana.jpg',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=8SbUC-UaAxE",
            },
            {
                url: 'https://www.youtube.com/watch?v=djV11Xbc914'
            },
            {
                url: 'https://www.youtube.com/watch?v=hTWKbfoikeg'
            },
            {
                url: "https://www.youtube.com/watch?v=1w7OgIMMRc4",
            },
            {
                url: "https://www.youtube.com/watch?v=9jK-NcRmVcw",
            },
            {
                url: "https://www.youtube.com/watch?v=OMOGaugKpzs",
            },
            {
                url: "https://www.youtube.com/watch?v=xwtdhWltSIg",
            },
            {
                url: "https://www.youtube.com/watch?v=btPJPFnesV4",
            },
            {
                url: "https://www.youtube.com/watch?v=zRIbf6JqkNc",
            },
            {
                url: "https://www.youtube.com/watch?v=Rbm6GXllBiw",
            },
            {
                url: "https://www.youtube.com/watch?v=ErvgV4P6Fzc",
            },
            {
                url: "https://www.youtube.com/watch?v=NMNgbISmF4I",
            },
            {
                url: "https://www.youtube.com/watch?v=qeMFqkcPYcg",
            },
            {
                url: "https://www.youtube.com/watch?v=UrIiLvg58SY",
            },
            {
                url: "https://www.youtube.com/watch?v=YR5ApYxkU-U",
            },
            {
                url: "https://www.youtube.com/watch?v=rY0WxgSXdEE",
            },
            {
                url: "https://www.youtube.com/watch?v=o1tj2zJ2Wvg",
            },
            {
                url: "https://www.youtube.com/watch?v=JkK8g6FMEXE",
            },
            {
                url: "https://www.youtube.com/watch?v=vabnZ9-ex7o",
            },
            {
                url: "https://www.youtube.com/watch?v=Qt2mbGP6vFI",
            },
            {
                url: "https://www.youtube.com/watch?v=xPU8OAjjS4k",
            },
            {
                url: "https://www.youtube.com/watch?v=S_E2EHVxNAE",
            },
            {
                url: "https://www.youtube.com/watch?v=qfNmyxV2Ncw",
            },
            {
                url: "https://www.youtube.com/watch?v=1Cw1ng75KP0",
            },
            {
                url: "https://www.youtube.com/watch?v=-oqAU5VxFWs",
            },
            {
                url: "https://www.youtube.com/watch?v=etAIpkdhU9Q",
            },
            {
                url: "https://www.youtube.com/watch?v=Lo2qQmj0_h4",
            },
            {
                url: "https://www.youtube.com/watch?v=zSmOvYzSeaQ",
            },
            {
                url: "https://www.youtube.com/watch?v=loWXMtjUZWM",
            },
            {
                url: "https://www.youtube.com/watch?v=a01QQZyl-_I&",
            },
            {
                url: "https://www.youtube.com/watch?v=3wxyN3z9PL4",
            },
            {
                url: "https://www.youtube.com/watch?v=l482T0yNkeo",
            },
            {
                url: "https://www.youtube.com/watch?v=dpmAY059TTY",
            },
            {
                url: "https://www.youtube.com/watch?v=KmWE9UBFwtY",
            },
            {
                url: "https://www.youtube.com/watch?v=NRtvqT_wMeY",
            },
            {
                url: "https://www.youtube.com/watch?v=yRYFKcMa_Ek",
            },
            {
                url: "https://www.youtube.com/watch?v=YgSPaXgAdzE",
            },
            {
                url: "https://www.youtube.com/watch?v=CBTOGVb_cQg",
            }
        ]
    },
    {
        name: 'Jazz',
        thumbnail: 'https://i.discogs.com/YAjlquecpjcTyB32Ps8tocCak_Mbw8XGdpZDFWi_LTQ/rs:fit/g:sm/q:90/h:595/w:600/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTQzOTQ4/OC0xMjI2MTYxODEz/LmpwZWc.jpeg',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=71Gt46aX9Z4",
            },
            {
                url: 'https://www.youtube.com/watch?v=bb1SrngIufQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=H77fRz1rybs'
            },
            {
                url: 'https://www.youtube.com/watch?v=ioOzsi9aHQQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=9Pes54J8PVw'
            },
            {
                url: 'https://www.youtube.com/watch?v=SgXSomPE_FY'
            },
            {
                url: 'https://www.youtube.com/watch?v=GzmS4p3jXvs'
            },
            {
                url: 'https://www.youtube.com/watch?v=0G383538qzQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=zq7hltwb_yc'
            },
            {
                url: 'https://www.youtube.com/watch?v=ZVLEYerz5rc'
            },
            {
                url: 'https://www.youtube.com/watch?v=PsgAHFviYcY'
            },
            {
                url: 'https://www.youtube.com/watch?v=cEXhZ8PwM-Y'
            },
            {
                url: 'https://www.youtube.com/watch?v=WcF8Aos4XDA'
            },
            {
                url: 'https://www.youtube.com/watch?v=5ODL5_djyBI'
            },
            {
                url: 'https://www.youtube.com/watch?v=TTfVNYJxXw8'
            },
            {
                url: 'https://www.youtube.com/watch?v=bSfqNEvykv0'
            },
            {
                url: 'https://www.youtube.com/watch?v=5lrSdW8p4u4'
            },
            {
                url: 'https://www.youtube.com/watch?v=bqQKE4kkrUc'
            },
            {
                url: 'https://www.youtube.com/watch?v=S5NPriAa8so'
            },
            {
                url: 'https://www.youtube.com/watch?v=UiHmeHZAc0s'
            },
            {
                url: 'https://www.youtube.com/watch?v=gUm_VC3vBt4'
            },
            {
                url: 'https://www.youtube.com/watch?v=2A6hG6Xg6zQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=-aRnzKDiIS0'
            },
            {
                url: 'https://www.youtube.com/watch?v=N-KluFB9A8M'
            },
            {
                url: 'https://www.youtube.com/watch?v=4zAThXFOy2c'
            },
            {
                url: 'https://www.youtube.com/watch?v=hC8CH0Z3L54'
            },
            {
                url: 'https://www.youtube.com/watch?v=O_5oXqvxaAk'
            },
            {
                url: 'https://www.youtube.com/watch?v=QcJ2eb3ojPM'
            },
            {
                url: 'https://www.youtube.com/watch?v=rB6OlJqV1rQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=rnQzXv-bbkY'
            },
            {
                url: 'https://www.youtube.com/watch?v=QuHQfC01SKo'
            },
            {
                url: 'https://www.youtube.com/watch?v=UjZzaTo-MYI'
            }
        ]
    },
    {
        name: 'Chill',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/summer-chillout-cd-cover-artwork-template-design-47093542f55e5139ea7173d1c2261c92_screen.jpg?ts=1589615245',
        playlists: [
            {
                url: "https://www.youtube.com/watch?v=JdqL89ZZwFw",
            },
            {
                url: 'https://www.youtube.com/watch?v=lTRiuFIWV54'
            },
            {
                url: 'https://www.youtube.com/watch?v=9FvvbVI5rYA'
            },
            {
                url: 'https://www.youtube.com/watch?v=xocnshwEbrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=ROy57arUE1s'
            },
            {
                url: 'https://www.youtube.com/watch?v=QZTDZFtbrec'
            },
            {
                url: 'https://www.youtube.com/watch?v=6H-PLF2CR18'
            },
            {
                url: 'https://www.youtube.com/watch?v=LsWACxHMWBI'
            },
            {
                url: 'https://www.youtube.com/watch?v=c3suauAz0zQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=c3jb-47ikqY'
            },
            {
                url: 'https://www.youtube.com/watch?v=lf6refTxQs8'
            },
            {
                url: 'https://www.youtube.com/watch?v=liHgt4CbodY'
            },
            {
                url: 'https://www.youtube.com/watch?v=YpGjaJ1ettI'
            },
            {
                url: 'https://www.youtube.com/watch?v=dTuLMnX3Vlw'
            },
            {
                url: 'https://www.youtube.com/watch?v=90QqkQNzMFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=bz5q5gl2uZA'
            },
            {
                url: 'https://www.youtube.com/watch?v=FjHGZj2IjBk'
            },
            {
                url: 'https://www.youtube.com/watch?v=bP9gMpl1gyQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=1fueZCTYkpA'
            },
            {
                url: 'https://www.youtube.com/watch?v=q9p0S7hGcrI'
            },
            {
                url: 'https://www.youtube.com/watch?v=PtIKsk1Qabw'
            },
            {
                url: 'https://www.youtube.com/watch?v=CfPxlb8-ZQ0'
            },
            {
                url: 'https://www.youtube.com/watch?v=r0sjCawEOKk'
            },
            {
                url: 'https://www.youtube.com/watch?v=TGan48YE9Us'
            },
            {
                url: 'https://www.youtube.com/watch?v=4mkNvBWdqFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=TWTV4T3yxzs'
            },
            {
                url: 'https://www.youtube.com/watch?v=spRerxsOLXk'
            },
            {
                url: 'https://www.youtube.com/watch?v=1w9kNO4eq9U'
            },
            {
                url: 'https://www.youtube.com/watch?v=lbpCmN1IqGk'
            },
            {
                url: 'https://www.youtube.com/watch?v=5mv1T3bjq_g'
            },
            {
                url: 'https://www.youtube.com/watch?v=QKUNo8MOzQA'
            },
            {
                url: 'https://www.youtube.com/watch?v=RtWgbht6qe8'
            },
            {
                url: 'https://www.youtube.com/watch?v=2LMiz9NTzVs'
            },
            {
                url: 'https://www.youtube.com/watch?v=UliRWJE0CaI'
            },
            {
                url: 'https://www.youtube.com/watch?v=LhSKG9EeFg8'
            },
            {
                url: 'https://www.youtube.com/watch?v=NJuSStkIZBg'
            }
        ]
    },
    {
        name: 'Electronic / Dance',
        thumbnail: 'https://d2n9ha3hrkss16.cloudfront.net/uploads/stage/stage_image/62032/optimized_large_thumb_stage.jpg',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=k3DBmAlUh1A'
            },
            {
                url: 'https://www.youtube.com/watch?v=3pL08H3WFrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=EfWmWlW2PvM'
            },
            {
                url: 'https://www.youtube.com/watch?v=3ztSQh7jh_Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=BtU2xhK5PZo'
            },
            {
                url: 'https://www.youtube.com/watch?v=ssKWFlclNFg'
            },
            {
                url: 'https://www.youtube.com/watch?v=IIUTf007y_w'
            },
            {
                url: 'https://www.youtube.com/watch?v=961v0E3b01g'
            },
            {
                url: 'https://www.youtube.com/watch?v=HvvECHLHKrM'
            },
            {
                url: 'https://www.youtube.com/watch?v=Q22MCFC0CP0'
            },
            {
                url: 'https://www.youtube.com/watch?v=0OKqK8Fr72k'
            },
            {
                url: 'https://www.youtube.com/watch?v=90RLzVUuXe4'
            },
            {
                url: 'https://www.youtube.com/watch?v=S83AQhEWmPY'
            },
            {
                url: 'https://www.youtube.com/watch?v=xkejbXejA-0'
            },
            {
                url: 'https://www.youtube.com/watch?v=BX0lKSa_PTk'
            },
            {
                url: 'https://www.youtube.com/watch?v=ELXuZBD6D_g'
            },
            {
                url: 'https://www.youtube.com/watch?v=T-jNkwesjpk'
            },
            {
                url: 'https://www.youtube.com/watch?v=EXIWlRrkjKE'
            },
            {
                url: 'https://www.youtube.com/watch?v=w8mBplMtwJ8'
            },
            {
                url: 'https://www.youtube.com/watch?v=vdzHlbFItlw'
            },
            {
                url: 'https://www.youtube.com/watch?v=l4UkYBr1NnA'
            },
            {
                url: 'https://www.youtube.com/watch?v=iqVLISbFZPc'
            },
            {
                url: 'https://www.youtube.com/watch?v=1VcFFvqQV8g'
            },
            {
                url: 'https://www.youtube.com/watch?v=MveDLwDIZiI'
            },
            {
                url: 'https://www.youtube.com/watch?v=R4kRgIkpTxQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=Rvc7ZsurcSY'
            },
            {
                url: 'https://www.youtube.com/watch?v=TfbK_sCRapM'
            },
            {
                url: 'https://www.youtube.com/watch?v=r0bhF7SJLYQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=e7HBypw4lhY'
            },
            {
                url: 'https://www.youtube.com/watch?v=PoP2Sa7wYNQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=NkrkAsRVLEA'
            },
            {
                url: 'https://www.youtube.com/watch?v=1_4ELAxKrDc'
            }
        ]
    },
    {
        name: 'Metal',
        thumbnail: 'https://www.revolvermag.com/sites/default/files/styles/original_image__844px_x_473px_/public/media/section-media/81hryxavzjl._sl1425_.jpg?itok=bjKLgbqe&timestamp=1559146162',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=l9VFg44H2z8'
            },
            {
                url: 'https://www.youtube.com/watch?v=AkFqg5wAuFk'
            },
            {
                url: 'https://www.youtube.com/watch?v=CSvFpBOe8eY'
            },
            {
                url: 'https://www.youtube.com/watch?v=6fVE8kSM43I'
            },
            {
                url: 'https://www.youtube.com/watch?v=DelhLppPSxY'
            },
            {
                url: 'https://www.youtube.com/watch?v=CD-E-LDc384'
            },
            {
                url: 'https://www.youtube.com/watch?v=HCBPmxiVMKk'
            },
            {
                url: 'https://www.youtube.com/watch?v=X4bgXH3sJ2Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=3nb7DD7vdQ0'
            },
            {
                url: 'https://www.youtube.com/watch?v=W3q8Od5qJio'
            },
            {
                url: 'https://www.youtube.com/watch?v=iywaBOMvYLI'
            },
            {
                url: 'https://www.youtube.com/watch?v=Nco_kh8xJDs'
            },
            {
                url: 'https://www.youtube.com/watch?v=F_6IjeprfEs'
            },
            {
                url: 'https://www.youtube.com/watch?v=94bGzWyHbu0'
            },
            {
                url: 'https://www.youtube.com/watch?v=jRGrNDV2mKc'
            },
            {
                url: 'https://www.youtube.com/watch?v=RFc-2aNZ6VY'
            },
            {
                url: 'https://www.youtube.com/watch?v=UNEDa3Hqnic'
            },
            {
                url: 'https://www.youtube.com/watch?v=JiDnB-CrrNs'
            },
            {
                url: 'https://www.youtube.com/watch?v=6rL4em-Xv5o'
            },
            {
                url: 'https://www.youtube.com/watch?v=Ps0MfBG5-Uo'
            },
            {
                url: 'https://www.youtube.com/watch?v=5ItHNdrPEh0'
            },
            {
                url: 'https://www.youtube.com/watch?v=GurkREc-q4I'
            },
            {
                url: 'https://www.youtube.com/watch?v=IHS3qJdxefY'
            },
            {
                url: 'https://www.youtube.com/watch?v=FNdC_3LR2AI'
            },
            {
                url: 'https://www.youtube.com/watch?v=uhBHL3v4d3I'
            },
            {
                url: 'https://www.youtube.com/watch?v=qw2LU1yS7aw'
            },
            {
                url: 'https://www.youtube.com/watch?v=Fwr1Z7uyXz4'
            },
            {
                url: 'https://www.youtube.com/watch?v=yPNFVj-pISU'
            },
            {
                url: 'https://www.youtube.com/watch?v=-0Ao4t_fe0I'
            },
            {
                url: 'https://www.youtube.com/watch?v=iPW9AbRMwFU'
            },
            {
                url: 'https://www.youtube.com/watch?v=XOzs1FehYOA'
            },
            {
                url: 'https://www.youtube.com/watch?v=viD6JMRGbbM'
            },
            {
                url: 'https://www.youtube.com/watch?v=2s3iGpDqQpQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=labytsb3gfI'
            },
            {
                url: 'https://www.youtube.com/watch?v=vfpgpf6QVnI'
            }
        ]
    },
    {
        name: 'Hip Hop',
        thumbnail: 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/hip-hop-modern-album-cover-video-design-template-feff1ee7028b6c491f3382b8b8932c11_screen.jpg?ts=1649518691',
        playlists: [
            {
                url: 'https://www.youtube.com/watch?v=-jEShhcnxIM'
            },
            {
                url: 'https://www.youtube.com/watch?v=hpK16l6fDsg'
            },
            {
                url: 'https://www.youtube.com/watch?v=NSCZ5awmH1U'
            },
            {
                url: 'https://www.youtube.com/watch?v=Xrk6JQNqM0g'
            },
            {
                url: 'https://www.youtube.com/watch?v=kC8YEw9h2-Q'
            },
            {
                url: 'https://www.youtube.com/watch?v=9dosj6p1DqY'
            },
            {
                url: 'https://www.youtube.com/watch?v=LuKm4L9ryB0'
            },
            {
                url: 'https://www.youtube.com/watch?v=IAJnDmMN5VU'
            },
            {
                url: 'https://www.youtube.com/watch?v=a90gzeTH9MI'
            },
            {
                url: 'https://www.youtube.com/watch?v=a90gzeTH9MI'
            },
            {
                url: 'https://www.youtube.com/watch?v=EgPaU9EBpls'
            },
            {
                url: 'https://www.youtube.com/watch?v=JCf7jrglH6A'
            },
            {
                url: 'https://www.youtube.com/watch?v=m4_9TFeMfJE'
            },
            {
                url: 'https://www.youtube.com/watch?v=tGTKY1dpo_E'
            },
            {
                url: 'https://www.youtube.com/watch?v=GHVDVz5Kcqg'
            },
            {
                url: 'https://www.youtube.com/watch?v=yedPuhzfVGE'
            },
            {
                url: 'https://www.youtube.com/watch?v=_yBh_I5BLRM'
            },
            {
                url: 'https://www.youtube.com/watch?v=Z4N8lzKNfy4'
            },
            {
                url: 'https://www.youtube.com/watch?v=IyDnzuFf9xk'
            },
            {
                url: 'https://www.youtube.com/watch?v=DbjDJLcNvdU'
            },
            {
                url: 'https://www.youtube.com/watch?v=l21wGxlWwPw'
            },
            {
                url: 'https://www.youtube.com/watch?v=t-ibVnD9A7I'
            },
            {
                url: 'https://www.youtube.com/watch?v=CUj2AWEJnwQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=pDFHyA7KgDw'
            },
            {
                url: 'https://www.youtube.com/watch?v=n7rE-Wlo5wg'
            },
            {
                url: 'https://www.youtube.com/watch?v=fUYKSIWKbEQ'
            },
            {
                url: 'https://www.youtube.com/watch?v=vq4hRDnGbDY'
            },
            {
                url: 'https://www.youtube.com/watch?v=UqmUxkRPBS0'
            },
            {
                url: 'https://www.youtube.com/watch?v=_f0ftiBSvRs'
            },
            {
                url: 'https://www.youtube.com/watch?v=pjXdDjUWkjk'
            },
            {
                url: 'https://www.youtube.com/watch?v=qwtyEKTGGQ8'
            },
            {
                url: 'https://www.youtube.com/watch?v=6gUiQ8CqLcY'
            },
            {
                url: 'https://www.youtube.com/watch?v=zLC-7Il-uYg'
            },
            {
                url: 'https://www.youtube.com/watch?v=pSY3i5XHHXo'
            },
            {
                url: 'https://www.youtube.com/watch?v=MtV0aeGEEYk'
            },
            {
                url: 'https://www.youtube.com/watch?v=K0hDSlWGhTE'
            }
        ]
    }
];

RenderPinnedChatRooms = (PinnedChatRooms) => {
    let container = $("#pinned-rooms-list")

    if (!$.isEmptyObject(PinnedChatRooms)) {
        $.each(PinnedChatRooms, function (i, Room) {
            if (!Room.is_masked) {
                switch (Room.room_name) {
                    case "Events":
                        icon = '<i class="far fa-calendar-alt"></i>'
                        break
                    case "411":
                        icon = '<i class="fas fa-hands-helping"></i>'
                        break
                    case "The Lounge":
                        icon = '<i class="fas fa-couch"></i>'
                        break
                }

                let element = `
                    <div class="pinned-chat-listing" data-roomID="${Room.id}">
                        <div class="pinned-chat-name">
                            ${Room.room_name}
                        </div>

                        <div class="pinned-chat-icon">
                            ${icon}
                        </div>
                    </div>
                `;

                container.append(element)
            }
        })
    }
};