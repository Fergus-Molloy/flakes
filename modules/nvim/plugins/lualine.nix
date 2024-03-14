{
  lualine = {
    enable = true;
    iconsEnabled = true;
    theme = "auto";
    componentSeparators = { left = "|"; right = "|"; };
    sectionSeparators = { left = ""; right = ""; };
    tabline = {
      lualine_a = [ "buffers" ];
    };
    sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "encoding" "filetype" ];
      lualine_y = [{
        name = "datetime";
        extraConfig = { style = "Time %H:%M"; };
      }];
      lualine_z = [ "searchcount" ];
    };
    inactiveSections = {
      lualine_a = [ "mode" ];
      lualine_c = [ "filename" ];
    };
  };
}
