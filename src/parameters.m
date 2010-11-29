function [ param ] = parameters( varargin )
%PARAMETERS Create/alter PARAM structure.
%   PARAM = PARAMETERS('NAME1',VALUE1,'NAME2',VALUE2,...) creates an integrator
%   options structure OPTIONS in which the named properties have the
%   specified values. Any unspecified properties have default values. 
%   
%   PARAM = PARAMETERS(OLDOPTS,'NAME1',VALUE1,...) alters an existing options
%   structure OLDOPTS.
%   
%   PARAMETERS with no input arguments displays all property names and their
%   possible values.
%
% Example use:
%
%   param = parameters('nProtoClass',3,'nEpochs',500,'eta1',1e-5)

  
    
%% Default parameters

% Training
param =  struct( ...
             'algo',    'rlvq'    ,...      
      'nProtoClass',    1         ,...     % # prototypes per class
       'StartEpoch',    1         ,...     % begin learning
          'nEpochs',    15       ,...     % # epochs (sweeps through entire data)
              'eta',    1e-2      ,...     % learning rate
             'eta1',    1e-5      ,...     % learning rate of relevances
             'alpha',   0      ,...   % causal relevance learning factor: 0=RLVQ, 1=maximum bias to causes
   'StartRelevance',    5       ,...      % time to start relevance learning
   'StartCausalRelevance', 5   ,...      % time to start causal relevance learning
       'show_plots',    1         ,...     % plots on/off
        'interval1',    5         ,...     % intervals between error calculations
        'interval2',    1        ,...     % intervals between plots
  'skip_test_error',    0         ,...     % calculate test error on/off
 'skip_train_error',    0          ...     % calculate train error on/off
  );


i = 1;
while i <= nargin
  arg = varargin{i};
  if ischar(arg)                         % arg is an option name
    break;
  end
  if ~isa(arg,'struct')                 % arg is a struct name
      error('MATLAB:parameters:NoPropStruct',...
          ['Expected argument %d to be a PARAM structure\ncreated with PARAMETERS.'], i);
  end
  param = arg;
  i = i + 1;
end

% A finite state machine to parse name-value pairs.
if rem(nargin-i+1,2) ~= 0
  error('MATLAB:parameters:ArgNameValueMismatch',...
        'Arguments must occur in name-value pairs.');
end

while i <= nargin
  arg = varargin{i};
  if ~isfield(param,arg)
      error('MATLAB:odeset:InvalidFieldName',...
          'Unrecognized struct field name ''%s''.', arg);
  end
  param = setfield(param,arg,varargin{i+1})
  i = i+2;
end
