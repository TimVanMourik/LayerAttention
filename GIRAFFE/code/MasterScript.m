% Code generated by GiraffeTools
configuration = [];
tvm_regressConfounds(configuration);

configuration = [];
tvm_realignFunctionals(configuration);

configuration = [];
tvm_smoothFunctionals(configuration);

configuration = [];
tvm_glm(configuration);

configuration = [];
tvm_glmToFMap(configuration);

configuration = [];
tvm_glmToTMap(configuration);

configuration = [];
tvm_retroicorBackProject(configuration);

configuration = [];
tvm_movieFrom4D(configuration);

configuration = [];
tvm_reconAll(configuration);

configuration = [];
tvm_useBbregister(configuration);

configuration = [];
tvm_volumeWithBoundariesToMovie(configuration);

configuration = [];
tvm_volumeWithBoundariesToMovie(configuration);

configuration = [];
tvm_recursiveBoundaryRegistration(configuration);

configuration = [];
tvm_boundariesToObj(configuration);

configuration = [];
tvm_makeLevelSet(configuration);

configuration = [];
tvm_laplacePotentials(configuration);

configuration = [];
tvm_gradient(configuration);

configuration = [];
tvm_computeDivergence(configuration);

configuration = [];
tvm_levelSetToObj(configuration);

configuration = [];
tvm_objToBoundary(configuration);

configuration = [];
tvm_volumeWithBoundariesToMovie(configuration);

configuration = [];
tvm_designMatrixToTimeCourse(configuration);

configuration = [];
tvm_volumetricLayering(configuration);

configuration = [];
tvm_roiToDesignMatrix(configuration);

configuration = [];
configuration.i_FunctionalFolder = 'Scans/Functional/Realigned/';
configuration.o_DesignMatrix = 'DesignMatrix/design1.mat';
tvm_design_empty(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design1.mat';
configuration.i_Stimulus = {'Stimulus/STIM_RightOn.mat', 'Stimulus/STIM_RightOff.mat', 'Stimulus/STIM_LeftOn.mat', 'Stimulus/STIM_LeftOff.mat'};
configuration.i_HrfParameters = [5, 10, 0.5, 0.5, 2, 0, 32];
configuration.i_Labels = {'Stimulus_{Right,On}', 'Stimulus_{Right,Off}', 'Stimulus_{Left,On}', 'Stimulus_{Left,Off}'};
configuration.i_TR = 3.06;
configuration.i_TemporalDerivative = false;
configuration.i_DispersionDerivative = false;
configuration.i_DiagonaliseElements = true;
configuration.o_DesignMatrix = 'DesignMatrix/design2.mat';
tvm_design_stimulus(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design2.mat';
configuration.o_DesignMatrix = 'DesignMatrix/design3.mat';
tvm_design_constant(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/basic_design.mat';
configuration.i_CutOffFrequency = 1/100;
configuration.i_TR = 3.06;
configuration.o_DesignMatrix = 'DesignMatrix/design4.mat';
tvm_design_highpassFilter(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design4.mat';
configuration.i_MotionFiles = 'Scans/Functional/Realigned/rp_EP3D_*.txt';
configuration.o_DesignMatrix = 'DesignMatrix/DesignStimulus.mat';
tvm_design_motionRegression(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/DesignStimulus.mat';
configuration.i_PhysioFiles = 'Scans/PhysioLog/Resp*.mat';
configuration.i_ScanTriggers = 'Scans/TimeStamps/Run*';
configuration.i_Order = 5;
configuration.i_Type = 'Respiration';
configuration.o_DesignMatrix = 'DesignMatrix/DesignStimulus.mat';
tvm_design_retroicor(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/DesignStimulus.mat';
configuration.i_PhysioFiles = 'Scans/PhysioLog/Puls*.mat';
configuration.i_ScanTriggers = 'Scans/TimeStamps/Run*';
configuration.i_Order = 5;
configuration.i_Type = 'Heartbeat';
configuration.o_DesignMatrix = 'DesignMatrix/DesignStimulus.mat';
tvm_design_retroicor(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design3.mat';
configuration.i_Deletions = {1:3, 1:3, 1:3, 1:3, 1:3, 1:3};
configuration.o_DesignMatrix = 'DesignMatrix/basic_design.mat';
tvm_design_removeVolumes(configuration);

% end of script