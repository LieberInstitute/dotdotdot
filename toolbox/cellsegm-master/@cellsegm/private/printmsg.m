% PRINTMSG Print message to screen
% 
%   PRINTMSG(MSG,FLAG) prints the message in MSG with uppercase if FLAG == 1,
%   else lowercase
%
%   =======================================================================================
%   Copyright (C) 2013  Erlend Hodneland
%   Email: erlend.hodneland@biomed.uib.no 
%
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%   =======================================================================================
%
function [] = printmsg(varargin)

msg = varargin{1};

flag = 0;
if nargin == 2
    flag = varargin{2};
end;
if flag == 1
    msg = upper(msg);
end;

level = 1;
if nargin == 3
    level = varargin{3};
end;
    
for i = 1 : level-1
    msg = ['    ' msg];
end;
disp(sprintf('%s',msg))
