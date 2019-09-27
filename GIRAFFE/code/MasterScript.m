% Code generated by GiraffeTools
configuration = [];
configuration.i_SourceDirectory = 'Scans/Functional/Raw';
configuration.o_OutputDirectory = 'Scans/Functional/Realigned';
configuration.o_MeanFunctional = 'Scans/Functional/MeanFunctional.nii';
tvm_realignFunctionals(configuration);

configuration = [];
configuration.i_SourceDirectory = 'Scans/Functional/Realigned';
configuration.i_SmoothingKernel = [4, 4, 4];
configuration.o_OutputDirectory = 'Scans/Functional/Smoothed/';
tvm_smoothFunctionals(configuration);

configuration = [];
configuration.i_FunctionalFolder = 'Scans/Functional/Realigned';
configuration.o_DesignMatrix = 'DesignMatrix/design_init.mat';
tvm_design_initialise(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_init.mat';
configuration.o_DesignMatrix = 'DesignMatrix/design_mean.mat';
tvm_design_constant(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_mean.mat';
configuration.i_Stimulus = {'Stimulus/STIM_RightOn.mat', 'Stimulus/STIM_RightOff.mat', 'Stimulus/STIM_LeftOn.mat', 'Stimulus/STIM_LeftOff.mat'};
configuration.i_HrfParameters = [5, 10, 0.5, 0.5, 2, 0, 32];
configuration.i_Labels = {'Stimulus_{Right,On}', 'Stimulus_{Right,Off}', 'Stimulus_{Left,On}', 'Stimulus_{Left,Off}'};
configuration.i_TR = 3.06;
configuration.i_TemporalDerivative = false;
configuration.i_DispersionDerivative = false;
configuration.i_DiagonaliseElements = true;
configuration.o_DesignMatrix = 'DesignMatrix/design_stim.mat';
tvm_design_stimulus(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_stim.mat';
configuration.i_Deletions = repmat({1:3}, 1, 18);
configuration.o_DesignMatrix = 'DesignMatrix/basic_remove_vols.mat';
tvm_design_removeVolumes(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/basic_remove_vols.mat';
configuration.i_CutOffFrequency = 1/100;
configuration.i_TR = 3.06;
configuration.o_DesignMatrix = 'DesignMatrix/design_filtered.mat';
tvm_design_highpassFilter(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_filtered.mat';
configuration.i_MotionFiles = 'Scans/Functional/Realigned/rp*.txt';
configuration.o_DesignMatrix = 'DesignMatrix/design_motion.mat';
tvm_design_motionRegression(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_motion.mat';
configuration.i_PhysioFiles = 'Scans/PhysioLog/Resp*.mat';
configuration.i_ScanTriggers = 'Scans/TimeStamps/Run*';
configuration.i_Order = 5;
configuration.i_Type = 'Respiration';
configuration.o_DesignMatrix = 'DesignMatrix/design_resp.mat';
tvm_design_retroicor(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/design_resp.mat';
configuration.i_PhysioFiles = 'Scans/PhysioLog/Puls*.mat';
configuration.i_ScanTriggers = 'Scans/TimeStamps/Run*';
configuration.i_Order = 5;
configuration.i_Type = 'Heartbeat';
configuration.o_DesignMatrix = 'DesignMatrix/Design.mat';
tvm_design_retroicor(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_ReferenceVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_SourceDirectory = 'Scans/Functional/Smoothed/';
configuration.i_Mask = 'RegionsOfInterest/Brain.nii';
configuration.o_Betas = 'Activation/BetasCanonicalHrf.nii';
configuration.o_ResidualSumOfSquares = 'Activation/RssCanonicalHrf.nii';
tvm_glm(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_Betas = 'Activation/BetasCanonicalHrf.nii';
configuration.i_Resolution = 50;
configuration.i_Order = 5;
configuration.i_PhysioType = {'Heartbeat'};
configuration.o_BackProjection = {'Activation/HeartrateMovie.nii'};
tvm_retroicorBackProject(configuration);

configuration = [];
configuration.i_VolumeFile = {'Activation/HeartrateMovie.nii'};
configuration.i_FramesPerSecond = 25;
configuration.i_Slice = 5;
configuration.o_Movie =  {'Activation/HeartrateMovie.avi'};
tvm_movieFrom4D(configuration);

configuration = [];
configuration.i_RegistrationVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_FreeSurferFolder = 'FreeSurfer';
configuration.i_DegreesOfFreedom = 12;
configuration.o_Boundaries = 'Boundaries/bbregister.mat';
configuration.o_RegisterDat = 'Coregistration/FreeSurfer/bbregister.dat';
configuration.o_CoregistrationMatrix = 'Coregistration/bbregister.mat';
tvm_useBbregister(configuration);

configuration = [];
configuration.i_ReferenceVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_Boundaries = 'Boundaries/bbregister.mat';
configuration.i_Axis = 'transversal';
configuration.o_RegistrationMovie = 'Coregistration/BBR.avi';
tvm_volumeWithBoundariesToMovie(configuration);

configuration = [];
configuration.i_ReferenceVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_Boundaries = 'Boundaries/bbregister.mat';
configuration.i_MinimumVoxels = 10;
configuration.i_MinimumVertices = 100;
configuration.i_CuboidElements = true;
configuration.i_Tetrahedra = true;
configuration.i_NeighbourSmoothing = 0.1;
configuration.i_Mode = 'syty';
configuration.i_ReverseContrast = true;
configuration.i_OptimisationMethod = 'GreveFischl';
configuration.i_ContrastMethod = 'average';
configuration.o_Boundaries = 'Boundaries/rbr.mat';
configuration.o_DisplacementMap = 'Boundaries/Displacement.nii';
tvm_recursiveBoundaryRegistration(configuration);

configuration = [];
configuration.i_ReferenceVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_Boundaries = 'Boundaries/rbr.mat';
configuration.i_Axis = 'transversal';
configuration.o_RegistrationMovie = 'Coregistration/RBR.avi';
tvm_volumeWithBoundariesToMovie(configuration);

configuration = [];
configuration.i_Boundaries = 'Boundaries/rbr.mat';
configuration.o_ObjWhite = 'LevelSets/?h.white.obj';
configuration.o_ObjPial = 'LevelSets/?h.pial.obj';
tvm_boundariesToObj(configuration);

configuration = [];
configuration.i_ReferenceVolume = 'Scans/Functional/MeanFunctional.nii';
configuration.i_ObjWhite = 'LevelSets/?h.white.obj';
configuration.i_ObjPial = 'LevelSets/?h.pial.obj';
configuration.o_SdfWhite = 'LevelSets/?h.white.sdf.nii';
configuration.o_SdfPial = 'LevelSets/?h.pial.sdf.nii';
configuration.o_White = 'LevelSets/brain.white.sdf.nii';
configuration.o_Pial = 'LevelSets/brain.pial.sdf.nii';
tvm_makeLevelSet(configuration);

configuration = [];
configuration.i_White = 'LevelSets/brain.white.sdf.nii';
configuration.i_Pial = 'LevelSets/brain.pial.sdf.nii';
configuration.o_LaplacePotential = 'LevelSets/LaplacePotential.nii';
tvm_laplacePotentials(configuration);

configuration = [];
configuration.i_Potential = 'LevelSets/LaplacePotential.nii';
configuration.o_Gradient = 'LevelSets/brain.gradient.nii';
tvm_gradient(configuration);

configuration = [];
configuration.i_VectorField = 'LevelSets/brain.gradient.nii';
configuration.o_Divergence = 'LevelSets/brain.curvature.nii';
tvm_computeDivergence(configuration);

configuration = [];
configuration.i_White = 'LevelSets/brain.white.sdf.nii';
configuration.i_Pial = 'LevelSets/brain.pial.sdf.nii';
configuration.i_Gradient = 'LevelSets/brain.gradient.nii';
configuration.i_Curvature = 'LevelSets/brain.curvature.nii';
configuration.i_Levels = 0:1/3:1;
configuration.o_Layering = 'LevelSets/brain.layers.nii';
configuration.o_LevelSet = 'LevelSets/brain.levels.nii';
tvm_volumetricLayering(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_Betas = 'Activation/BetasCanonicalHrf.nii';
configuration.i_ResidualSumOfSquares = 'Activation/RssCanonicalHrf.nii';
configuration.i_Contrast = {{ 'Stimulus_{Right,On}', '-Stimulus_{Right,Off}',  'Stimulus_{Left,On}', '-Stimulus_{Left,Off}'}};
configuration.o_TMap = {'Activation/T_Stimulus.nii'};
tvm_glmToTMap(configuration);

configuration = [];
configuration.i_Volumes = {'Activation/T_Stimulus.nii'};
configuration.i_Threshold = 7;
configuration.o_ThresholdedVolumes = {'RegionsOfInterest/StimulusActivation.nii'};
tvm_thresholdVolumes(configuration);

configuration = [];
configuration.i_Volumes = {'RegionsOfInterest/StimulusActivation.nii'};
configuration.o_Volumes = {'RegionsOfInterest/StimulusActivation.nii'};
tvm_binariseVolumes(configuration);

configuration = [];
configuration.i_ROI = {'RegionsOfInterest/StimulusActivation.nii'};
configuration.i_Layers = 'LevelSets/brain.layers.nii';
configuration.o_DesignMatrix = {'DesignMatrix/StimulusActivation.mat'};
tvm_roiToDesignMatrix(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_SourceDirectory = 'Scans/Functional/Realigned';
configuration.i_Confounds = {'Respiration', 'Heartbeat', 'Motion', 'Filter'};
configuration.o_OutputDirectory = 'Scans/Functional/Filtered/';
tvm_regressConfounds(configuration);

configuration = [];
configuration.i_DesignMatrix = {'DesignMatrix/StimulusActivation.mat'};
configuration.i_FunctionalFolder = 'Scans/Functional/Filtered/';
configuration.i_RegressionApproach = 'OLS';
configuration.o_TimeCourse = {'TimeCourses/StimulusActivation.mat'};
tvm_designMatrixToTimeCourse(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_Betas = 'Activation/BetasCanonicalHrf.nii';
configuration.i_ResidualSumOfSquares = 'Activation/RssCanonicalHrf.nii';
configuration.i_Contrast = {{'Respiration'},{'Heartbeat'},{'Motion'}};
configuration.o_FMap = {'Activation/F_Respiration.nii', 'Activation/F_Heartrate.nii', 'Activation/F_Motion.nii'};
tvm_glmToFMap(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.o_Image = 'DesignMatrix/design.fig';
tvm_design_saveToImage(configuration);

configuration = [];
configuration.i_DesignMatrix = 'DesignMatrix/Design.mat';
configuration.i_Betas = 'Activation/BetasCanonicalHrf.nii';
configuration.i_Resolution = 50;
configuration.i_Order = 5;
configuration.i_PhysioType = {'Respiration'};
configuration.o_BackProjection = {'Activation/RespirationMovie.nii'};
tvm_retroicorBackProject(configuration);

configuration = [];
configuration.i_VolumeFile = {'Activation/RespirationMovie.nii'};
configuration.i_FramesPerSecond = 25;
configuration.i_Slice = 5;
configuration.o_Movie =  {'Activation/RespirationMovie.avi'};
tvm_movieFrom4D(configuration);

% end of script