const isEnvBrowser = !(window).invokeNative
const parentResource = window?.GetParentResourceName ? window.GetParentResourceName() : 'phone-radio'
const resourceName = !isEnvBrowser ? parentResource : 'phone-radio'

function Post(name, data) {
    if (isEnvBrowser) return [];
    return new Promise((resolve, reject) => {
        $.post(`https://${resourceName}/${name}`, JSON.stringify(data ?? {}), (response) => {
            resolve(response);
        });
    })
};

const connectHistoryFrequency = async (freq) => {
    const options = [
        { key: 'connect', value: Lang("PHONE_NUI_RADIO_CONNECT_TO") + ' ' + freq }
    ]
    const { key } = await OpenSelectorAsync(Lang("PHONE_NUI_RADIO_CONNECT_SELECTOR"), options);
    if (key !== 'connect') return;
    connectChannel(freq)
}

const connectChannel = async (freq) => {
    if (!privateChannels.find(c => c.frequency == freq)) {
        Post("setRadio", {
            freq
        })
        await getHistory()
        return
    }
    const pass = await PromptModalAsync(Lang("PHONE_NUI_RADIO_CONNECT_PASSWORD"), Lang("PHONE_NUI_RADIO_CONNECT_PASSWORD_INFORMATION"), Lang("PHONE_NUI_RADIO_CONNECT_SELECT_PASSWORD"))
    if (!pass) return
    const checkPass = await Post("checkPrivateChannel", {
        freq,
        pass
    })
    if (!checkPass) return SendPhoneNotificationOld('radio', Lang("PHONE_NOTIFICATION_RADIO_TITLE"), Lang("PHONE_NOTIFICATION_RADIO_INVALID_PASSWORD"), 3000)
    Post("setRadio", {
        freq
    })
    await getHistory()
}

const getHistory = async () => {
    const history = await Post("getHistory");
    if (!history) return;
    $('#phone-radio-history-container').empty()
    let str = ''
    history.forEach(freq => {
        str += `
            <li onclick="connectHistoryFrequency('${freq}')">
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" class="ionicon" viewBox="0 0 512 512">
                        <path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z" fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32" />
                        <path d="M350.67 150.93l-117.2 46.88a64 64 0 00-35.66 35.66l-46.88 117.2a8 8 0 0010.4 10.4l117.2-46.88a64 64 0 0035.66-35.66l46.88-117.2a8 8 0 00-10.4-10.4zM256 280a24 24 0 1124-24 24 24 0 01-24 24z" />
                    </svg>
                    <p>${freq}</p>
                </div>
                <svg xmlns="http://www.w3.org/2000/svg" class="right-icon" viewBox="0 0 512 512">
                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="48" d="M184 112l144 144-144 144" />
                </svg>
            </li>
        `
    })
    $('#phone-radio-history-container').append(str)
}

const initPrivateChannels = () => {
    $('#phone-radio-private-channels').empty()
    let str = ''
    privateChannels.forEach(channel => {
        str += `
            <li onclick="connectChannel(${channel.frequency})">
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" class="ionicon" viewBox="0 0 512 512">
                        <path d="M448 256c0-106-86-192-192-192S64 150 64 256s86 192 192 192 192-86 192-192z" fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="32" />
                        <path d="M350.67 150.93l-117.2 46.88a64 64 0 00-35.66 35.66l-46.88 117.2a8 8 0 0010.4 10.4l117.2-46.88a64 64 0 0035.66-35.66l46.88-117.2a8 8 0 00-10.4-10.4zM256 280a24 24 0 1124-24 24 24 0 01-24 24z" />
                    </svg>
                    <div class="private-channel-info">
                        <h4>${channel.label}</h4>
                        <p>${channel.frequency}</p>
                    </div>
                </div>
                <svg xmlns="http://www.w3.org/2000/svg" class="right-icon" viewBox="0 0 512 512">
                    <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="48" d="M184 112l144 144-144 144" />
                </svg>
            </li>
        `
    })
    $('#phone-radio-private-channels').append(str)
}

$(document).on('click', '#phone-frequenz-join-button', async function () {
    const freq = DOMPurify.sanitize($('#phone-radio-frequenz-input').val())
    if (!freq || freq == '') return SendPhoneNotificationOld('radio', Lang('PHONE_NOTIFICATION_RADIO_TITLE'), Lang('PHONE_NOTIFICATION_RADIO_MISSING_FIELDS'), 3000)
    connectChannel(freq)
});

$(document).on('click', '#phone-frequenz-leave-button', async function () {
    var freq = DOMPurify.sanitize($('#phone-radio-frequenz-input').val())
    if (!freq || freq == '') return SendPhoneNotificationOld('radio', Lang('PHONE_NOTIFICATION_RADIO_TITLE'), Lang('PHONE_NOTIFICATION_RADIO_NO_CONNECT'), 3000)
    await Post("leaveRadio", {
        freq
    })
});