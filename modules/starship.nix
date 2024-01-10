{ config, lib, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "[](#eb6f92)$username$hostname[](bg:#3e8fb0 fg:#eb6f92)$directory[](fg:#3e8fb0 bg:#ea9a97)$git_branch$git_status[](fg:#ea9a97 bg:#9ccfd8)$nodejs$rust[](fg:#9ccfd8 bg:#c4a7e7)$cmd_duration[](#c4a7e7)$line_break $character";
      username = {
        show_always = true;
        style_user = "bg:#eb6f92";
        style_root = "bg:#eb6f92";
        format = "[$user]($style)";
      };
      hostname = {
        ssh_only = false;
        style = "bg:#eb6f92";
        format = "[@$hostname ]($style)";
      };
      directory = {
        style = "bg:#3e8fb0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = ".../";
        truncate_to_repo = true;
      };
      git_branch = {
        style = "bg:#ea9a97";
        format = "[ $symbol$branch ]($style)";
      };
      git_status = {
        style = "bg:#ea9a97";
        format = "[$all_status$ahead_behind ]($style)";
      };
      nodejs = {
        style = "bg:#9ccfd8";
        format = "[ $symbol ($version)]($style)";
      };
      rust = {
        style = "bg:#9ccfd8";
        format = "[ $symbol\($toolchain\)]($style)";
      };
      cmd_duration = {
        style = "bg:#c4a7e7";
        format = "[ $duration]($style)";
      };
    };
  };
}
