function checkToggle(src, endpoint) {
    var target = $(src.attr('data-target'));

    var d =
        {
            val: target.attr('class')
        }
    if (d.val.indexOf('show') != -1) {
        d.val = d.val.replace('show', '');
    }
    else {
        d.val = d.val + ' show';
    }

    $.ajax(
        {
            type: "POST",
            url: endpoint,
            data: JSON.stringify(d),
            contentType: "application/json; charset=utf-8",
            success: function (msg) {
            },
            error: function (msg) {
                alert(msg);
            }
        });
}

function Confirm(text) {
    return confirm(text);
}

function showHelpImage(image_img, image_name, event) {
    image_img.attr('src', '../App_Themes/Default/Images/help/' + image_name);
    image_img.css({ 'display': 'block', 'top': event.pageY - 20, 'left': event.pageX - 20 });
}

function hideHelpImage(image_img) {
    image_img.css({ 'display': 'none' });
}

function toggleHelpImage(image_img, image_name, event) {
    if (image_img.attr('src').indexOf(image_name) != -1 && image_img.css('display') === 'block') {
        hideHelpImage(image_img);
    }
    else {
        showHelpImage(image_img, image_name, event);
    }
}

function SeedData(contestId) {
    $.ajax(
        {
            type: "POST",
            url: "/api/external/contests/" + contestId + "/seed",
            data: "",
            contentType: "application/json; charset=utf-8",
            success: function (msg) {
                alert("Seed completed");
            },
            error: function (msg) {
                alert(msg);
            }
        });
}

function ShowErrorInfo(msg) {
    var message = typeof (msg) === 'string'
        ? msg 
        : !msg.responseJSON
            ? 'Error occured.'
            : msg.responseJSON.ExceptionMessage
                ? msg.responseJSON.ExceptionMessage
                : msg.responseJSON.Message
                    ? msg.responseJSON.Message
                    : 'Error occured.';

    $('#infoModal .modal-body').removeClass('text-info');
    $('#infoModal .modal-body').addClass('text-danger');
    $('#infoModal .modal-body').html(message);
    $('#infoModal').modal('show');
}

function MakeBet_Load(ev, src, gameId, userId) {

    if (window.event)
        window.event.stopPropagation();
    else
        ev.preventDefault();

    $.ajax(
        {
            type: "GET",
            url: "/api/games/" + gameId,
            data: "",
            contentType: "application/json; charset=utf-8",
            success: function (gameResult) {

                var d = {
                    GameId: gameId,
                    UserId: userId
                };

                $.ajax(
                    {
                        type: "POST",
                        url: "/api/bets/",
                        data: JSON.stringify(d),
                        contentType: "application/json; charset=utf-8",
                        success: function (betResult) {
                            // Load data and put it to target
                            var target = $(src.attr('data-target'));
                            target.find('.make-bet--contest-name').html(gameResult.ContestName);
                            target.find('.make-bet--gamedate').html(gameResult.GameDateString);
                            target.find('.make-bet--team1-points').html(gameResult.Team1Points ? parseFloat(gameResult.Team1Points).toFixed(2) : '-');
                            target.find('.make-bet--draw-points').html(gameResult.DrawPoints ? parseFloat(gameResult.DrawPoints).toFixed(2) : '-');
                            target.find('.make-bet--team2-points').html(gameResult.Team2Points ? parseFloat(gameResult.Team2Points).toFixed(2) : '-');
                            target.find('.make-bet--team1-name').html(gameResult.Team1Name);
                            target.find('.make-bet--team2-name').html(gameResult.Team2Name);
                            target.find('.make-bet--multiply').html(parseFloat(gameResult.MultiplyValue).toFixed(2));
                            target.find('.make-bet--team1-banner').attr('src', gameResult.Team1Banner);
                            target.find('.make-bet--team2-banner').attr('src', gameResult.Team2Banner);

                            target.find('.make-bet--team1-score').val(betResult ? betResult.Team1Score : "0");
                            target.find('.make-bet--team2-score').val(betResult ? betResult.Team2Score : "0");

                            target.find('.make-bet--game-id').val(gameId);
                            target.find('.make-bet--user-id').val(userId);

                            target.modal('show');
                        },
                        error: function (msg) {
                            ShowErrorInfo(msg);
                        }
                    });
            },
            error: function (msg) {
                ShowErrorInfo(msg);
            }
        });
}

function MakeBet(src) {
    var target = $('#betModal');
    var t1 = target.find('.make-bet--team1-score').val();
    var t2 = target.find('.make-bet--team2-score').val();
    //debugger;
    if (t1 == parseInt(t1, 10) && t2 == parseInt(t2, 10) && t1 >= 0 && t2 >= 0) {

        var d = {
            GameId: parseInt(target.find('.make-bet--game-id').val(), 10),
            UserId: parseInt(target.find('.make-bet--user-id').val(), 10),
            Team1Score: parseInt(t1, 10),
            Team2Score: parseInt(t2, 10)
        };

        $.ajax(
            {
                type: "POST",
                url: "/api/bets/makebet",
                data: JSON.stringify(d),
                contentType: "application/json; charset=utf-8",
                success: function (msg) {
                    $('.make-bet--refresh-grid').click();
                },
                error: function (msg) {
                    ShowErrorInfo(msg);
                }
            });
        target.modal('hide');
    }
    else {
        ShowErrorInfo('Entered values are invalid.');
    }
}

function RemoveBet(betId) {
    alert('Bet Removed: ' + betId);
}

function ShowAllBets_Load(ev, src, gameId, userId) {
    if (window.event)
        window.event.stopPropagation();
    else
        ev.preventDefault();

    $.ajax(
        {
            type: "GET",
            url: "/api/bets/game/" + gameId,
            data: "",
            contentType: "application/json; charset=utf-8",
            success: function (betsResult) {
                // Load data and put it to target
                var target = $(src.attr('data-target'));
                target.find('.all-bets--contest-name').html(betsResult.Game.ContestName);
                target.find('.all-bets--gamedate').html(betsResult.Game.GameDateString);
                target.find('.all-bets--team1-points').html(betsResult.Game.Team1Points ? parseFloat(betsResult.Game.Team1Points).toFixed(2) : '-');
                target.find('.all-bets--draw-points').html(betsResult.Game.DrawPoints ? parseFloat(betsResult.Game.DrawPoints).toFixed(2) : '-');
                target.find('.all-bets--team2-points').html(betsResult.Game.Team2Points ? parseFloat(betsResult.Game.Team2Points).toFixed(2) : '-');
                target.find('.all-bets--team1-name').html(betsResult.Game.Team1Name);
                target.find('.all-bets--team2-name').html(betsResult.Game.Team2Name);
                target.find('.all-bets--multiply').html(parseFloat(betsResult.Game.MultiplyValue).toFixed(2));
                target.find('.all-bets--team1-banner').attr('src', betsResult.Game.Team1Banner);
                target.find('.all-bets--team2-banner').attr('src', betsResult.Game.Team2Banner);
                target.find('.all-bets--team1-score').html(betsResult.Game.Team1Score || betsResult.Game.Team1Score == 0 ? betsResult.Game.Team1Score : "-");
                target.find('.all-bets--team2-score').html(betsResult.Game.Team2Score || betsResult.Game.Team2Score == 0 ? betsResult.Game.Team2Score : "-");
                target.find('.all-bets--description').html(betsResult.Game.Description ? betsResult.Game.Description.replace(/\n/g, "<br />") : "");

                var usersBets = target.find(".all-bets--users-bets");

                usersBets.jsGrid({
                    width: "auto",
                    height: "auto",
                    pageSize: 50,

                    //sorting: true,
                    paging: true,

                    data: betsResult.Bets,

                    fields: [
                        { name: "UserLogin", type: "text", title: "Login" },
                        { name: "BetDateString", type: "date", title: "Bet date" },
                        { name: "Team1Score", type: "number", title: betsResult.Game.Team1Name },
                        { name: "Team2Score", type: "number", title: betsResult.Game.Team2Name },
                        { name: "Points", type: "number", title: "Points", formatter: function (cellvalue, options, rowObject) { return cellvalue === undefined || isNull(cellvalue) || cellvalue === 'NULL' ? "-" : cellvalue; } }

                        //{ name: "Address", type: "text", width: 200 },
                        //{ name: "Country", type: "select", items: db.countries, valueField: "Id", textField: "Name" },
                        //{ name: "Married", type: "checkbox", title: "Is Married" }
                    ]
                });

                target.modal('show');
            },
            error: function (msg) {
                ShowErrorInfo(msg);
            }
        });
}

function checkInputNumberNotNegative() {
    var kc = event.charCode || event.keyCode;
    return kc >= 48 && kc <= 57;
}