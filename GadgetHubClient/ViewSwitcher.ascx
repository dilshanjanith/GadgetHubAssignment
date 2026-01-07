<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewSwitcher.ascx.cs" Inherits="GadgetHubClient.ViewSwitcher" %>

<style>
    #viewSwitcher {
        background:rgba(22, 33, 62, 0.9);
        border:1px solid #2d3561;
        border-radius:8px;
        padding:10px 20px;
        margin:15px 0;
        text-align:center;
        color:#aaa;
        font-size:14px;
        box-shadow:0 4px 12px rgba(0, 0, 0, 0.3);
    }

    #viewSwitcher a {
        color:#00d9ff;
        text-decoration: none;
        font-weight: 600;
        transition:all 0.3s ease;
    }

    #viewSwitcher a:hover {
        color:#00ffff;
        text-shadow: 0 0 8px rgba(0, 217, 255, 0.5);
    }
</style>

<div id="viewSwitcher">
    <%:CurrentView %> view | <a href="<%:SwitchUrl %>" data-ajax="false">Switch to <%:AlternateView %></a>
</div>