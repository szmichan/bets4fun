<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ucGameRules.ascx.cs" Inherits="Bets4Fun.UserControls.UcCalendar" %>

<div class="rules-items">
    <div>
        <h2 class="rules-item-title">
            <asp:Label ID="TitleLabel" runat="server" Text="Scoring points:"></asp:Label>
        </h2>
        <ol class="rules-item-list">
            <li class="one">
                <asp:Label ID="Rule1Label1" runat="server" Text="przy każdym meczu w nawiasach widoczna jest ilość punktów, które można zdobyć za wytypowanie wyniku (zwycięstwo/remis)">
                    for each match there are visible points that are available to score for result prediction (winner/draw)
                </asp:Label>
                <button type="button" class="btn btn-info sheen" data-toggle="tooltip" data-html="true" title="<div class='tooltip-help-points'></div>">
                    INFO
                </button>
            </li>
            <li class="two">
                <asp:Label ID="Rule2Label1" runat="server" Text="dodatkowo za wytypowanie dokładnego wyniku spotkania (zgodna ilość bramek po obu stronach) ">
                    additionally for exact prediction (correct number of goals on each side) <b><em>scored points are doubled</em></b>
                </asp:Label>
            </li>
            <li class="three">
                <asp:Label ID="Label4" runat="server" Text="końcowa ilość zdobytych puntków w danym meczu jest dodatkowo przemnażana przez współczynnik określający">
                    final score is multiplied by factor which determines <b><em>rank of the match</em></b>. It will grow accordingly to competition stage (group stage, round of 16, quater finals etc.)
                </asp:Label>
                <button type="button" class="btn btn-info sheen" data-toggle="tooltip" data-html="true" title="<div class='tooltip-help-weights'></div>">
                    INFO
                </button>
            </li>
            <li class="four">
                <asp:Label ID="Label11" runat="server" Text="wartości punktów możliwych do zdobycia ustalane są na podstawie zakładów bukmacherskich i mogą się nieznacznie zmieniać - ">
                    points available to score are set accordingly to one of the betting portals (7 points is max, 2 is min) and they may change - <b><em>but not later than 2 hours before the match starts</em></b>
                </asp:Label>
            </li>
        </ol>
    </div>
    <br />
    <div>
        <h2 class="rules-item-title">
            <asp:Label ID="Label2" runat="server" Text="Making bets:" Font-Bold="True" Font-Underline="True"></asp:Label>
        </h2>
        <ol class="rules-item-list">
            <li class="one">
                <asp:Label ID="Label6" runat="server" Text="od fazy pucharowej typujemy wynik meczu do końca regulaminowego czasu gry (90 min)">
                    from the knockout phase we bet the result of the match until the end of the regular time of the game (90 min)
                </asp:Label>
            </li>
            <li class="two">
                <asp:Label ID="Label10" runat="server" Text="możliwość typowania i zmieniania wyników jest blokowana na 5 min przed rozpoczęciem meczu">
                    you can change your bets as many times as you want, but the possibility to do it for particular match is blocked 5 minutes before this match starts
                </asp:Label>
            </li>
            <li class="three">
                <asp:Label ID="Label13" runat="server" Text="możliwość podglądania wyników typowanych przez inne osoby jest blokowana na 1h przed rozpoczęciem meczu i udostępniana zaraz po jego rozpoczęciu">
                    the possibility to view the results typed by other people is available 5 minutes after match begins
                </asp:Label>
            </li>
        </ol>
    </div>
    <br />
    <div>
        <h2 class="rules-item-title">
            <asp:Label ID="Label1" runat="server" Text="Participation options:" Font-Bold="True" Font-Underline="True"></asp:Label>
        </h2>
        <ol class="rules-item-list">
            <li class="one">
                <asp:Label ID="Label3" runat="server" Text="FOR FUN - logujemy się, obstawiamy wyniki, śledzimy swoją pozycję w rankingu">
                    FOR FUN - we log in, bet the results, track our position in the ranking
                </asp:Label>
            </li>
            <li class="two">
                <asp:Label ID="Label7" runat="server">
                    FOR MONEY - you have to transfer 20 PLN to my bank account. 
                    If you choose first option in the transfer title write your login and competition name (eg. smichan, EURO 2040). 
                    Bank account number was sent in activation mail (if you lost it write to <a href="mailto:b3ts4fun@gmail.com">b3ts4fun@gmail.com</a>). 
                    Payments are accepted to the first whistle in the first match of the competition. 
                    After money transfer is confirmed I will add you to separate league so on <a href="/User/Ranking.aspx">Classification</a> screen you will be able to switch the <em>League</em> to see how many people are participating in that way and how much money is in the pot. 
                    <b>The winner takes 70% of the total money collected, runner-up 20% and the third place 10% !!!</ b>
                </asp:Label>
            </li>
        </ol>
    </div>
    <br />
    <br />
    <div>
        <asp:Label ID="Label9" runat="server">
            All comments and suggestions can be directed to:
        </asp:Label>
        <a href="mailto:b3ts4fun@gmail.com">b3ts4fun@gmail.com</a>
    </div>
    <br />
    <br />
    <div>
        <asp:Label ID="Label8" runat="server" Text="Need more fun? Here is link to fantasy game: "></asp:Label>
        <br />
        <a href="https://gaming.uefa.com/en/eurofantasy/leagues/6g1RRu/0073006D0069006300680061006E00730020006C00650061006700750065/smichan" target="_blank">
            <img src="/App_Themes/Default/Images/euro2024/logo.png" class="fantasy-img" style="width: 200px;" />
            <br />
            UEFA EURO 2024™ Fantasy Football
        </a>
        <br />
        league code: 6g1RRu
    </div>
</div>
