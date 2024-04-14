let privateChannels
const js = [
    'app.js'
]

function resizeHandler() {
    const width = window.innerWidth;
    const height = window.innerHeight;
    const device = document.getElementById('phone-device');

    const PHONE_WIDTH = $('#phone-device').width();
    const PHONE_HEIGHT = $('#phone-device').height();

    let scaleFactor = Math.min(width / PHONE_WIDTH, height / PHONE_HEIGHT) * 0.83; // 0.83 = Config.ScaleMultiplier
    if (PHONE_WIDTH === 1920 && PHONE_HEIGHT === 1080) scaleFactor = 1.0; // scaleFactor = Config.DefaultScale

    device.style.transform = `scale(${scaleFactor})`;
    device.style.transformOrigin = 'bottom right';
    device.style.willChange = 'transform';
};

window.addEventListener("load", () => {
    if (window.invokeNative) {
        document.body.innerHTML = document.getElementById("phone-device").innerHTML;
        return;
    }

    document.body.style.visibility = "visible";
    document.body.style.display = "block";
    document.body.style.backgroundColor = "black";
    resizeHandler();
    window.addEventListener('resize', resizeHandler);
});

const combineParentWindow = () => {
    const parent = window.parent
    window.OpenSelector = parent.OpenSelector
    window.OpenSelectorAsync = parent.OpenSelectorAsync
    window.PromptModal = parent.PromptModal
    window.PromptModalAsync = parent.PromptModalAsync
    window.OpenSelectCamItem = parent.OpenSelectCamItem
    window.OpenSelectPhotoMenu = parent.OpenSelectPhotoMenu
    window.OpenImage = parent.OpenImage
    window.SendPhoneNotification = parent.SendPhoneNotification
    window.SendPhoneNotificationOld = parent.SendPhoneNotificationOld
    window.OpenSelectGifMenu = parent.OpenSelectGifMenu
    window.OpenRequestMoneyModel = parent.openRequestMoneyModal
    window.Rotate = parent.Rotate
    window.SetupCall = parent.SetupCall
    window.Lang = parent.Lang
    window.Lang = parent.Lang
}

const actionToFns = new Map([
    ['foo', (...args) => foo(...args)],
])

const convertActionToFn = (data) => {
    const action = data.action
    const args = data
    const fn = actionToFns.get(action)
    if (fn) fn(args)
}

window.addEventListener('message', async e => {
    if (e.data === 'app-opened') {
        $(".phone-recent-message-headline").text(Lang("PHONE_NOTIFICATION_RADIO_TITLE"));
        $("#phone-radio-frequenz-input").attr("placeholder", Lang("PHONE_NUI_RADIO_CONNECT_FREQUENCY_PLACEHOLDER"));
        $("#phone-frequenz-join-button").text(Lang("PHONE_NUI_RADIO_BUTTON_CONNECT"));
        $("#phone-frequenz-leave-button").text(Lang("PHONE_NUI_RADIO_BUTTON_LEAVE"));
        $(".private-radios a").text(Lang("PHONE_NOTIFICATION_RADIO_PRIVATE"));
        $(".history-radios a").text(Lang("PHONE_NOTIFICATION_RADIO_RECORD"));
        if (!privateChannels) {
            privateChannels = await Post('getPrivateChannels')
            initPrivateChannels()
        }
        getHistory()
        return
    }
    if (e.data !== 'phone-load') return convertActionToFn(e.data)
    combineParentWindow()
})
