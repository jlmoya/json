// Copyright (C) 2008 - INRIA
// Copyright (C) 2009 - DIGITEO

// This file is released into the public domain

mode(-1);
lines(0);

TOOLBOX_NAME  = "JSON";
TOOLBOX_TITLE = "The Scilab JSON Toolbox";
toolbox_dir   = get_absolute_file_path("builder.sce");

// Check Scilab's version
// =============================================================================

try
	v = getversion("scilab");
catch
	error(gettext("Scilab 5.2 or more is required."));
end

// Scilab 2027 returns v = [2027 0 0 ...]: this guard used to read the MINOR
// version alone, so 0 < 2 rejected a Scilab 400 majors NEWER than the 5.2 it
// asks for. Compare the major first, and only fall back to the minor within
// the 5.x line the check was written for.
if v(1) < 5 | (v(1) == 5 & v(2) < 2) then
	// new API in scilab 5.2
	error(gettext('Scilab 5.2 or more is required.'));  
end

// Check development_tools module avaibility
// =============================================================================

if ~with_module('development_tools') then
  error(msprintf(gettext('%s module not installed.'),'development_tools'));
end

// Action
// =============================================================================

tbx_builder_macros(toolbox_dir);
// tbx_builder_src(toolbox_dir);
// tbx_builder_gateway(toolbox_dir);
// tbx_builder_help(toolbox_dir);
tbx_build_loader(TOOLBOX_NAME, toolbox_dir);
tbx_build_cleaner(TOOLBOX_NAME, toolbox_dir);

// Clean variables
// =============================================================================

clear toolbox_dir TOOLBOX_NAME TOOLBOX_TITLE;
