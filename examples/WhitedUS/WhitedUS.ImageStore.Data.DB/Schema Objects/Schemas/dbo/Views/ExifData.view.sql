
CREATE VIEW [dbo].[ExifData]
AS --
	SELECT *
	FROM (
		SELECT 
			ContentItemID
			,Name
			,Value
		FROM ContentMetaData
	) d
	PIVOT (
		MAX(Value)
		FOR Name IN (
			[EXIF.ApertureValue],
			[EXIF.BrightnessValue],
			[EXIF.ColorSpace],
			[EXIF.Contrast],
			[EXIF.DateTimeDigitized],
			[EXIF.DateTimeOriginal],
			[EXIF.DigitalZoomRatio],
			[EXIF.ExifVersion],
			[EXIF.ExposureBiasValue],
			[EXIF.ExposureIndex],
			[EXIF.ExposureMode],
			[EXIF.ExposureProgram],
			[EXIF.ExposureTime],
			[EXIF.FileSource],
			[EXIF.Flash.Fired],
			[EXIF.Flash.FirReturned],
			[EXIF.Flash.Function],
			[EXIF.Flash.Mode],
			[EXIF.Flash.RedEyeReductionSupport],
			[EXIF.FlashEnergy],
			[EXIF.FlashpixVersion],
			[EXIF.FNumber],
			[EXIF.FocalLength],
			[EXIF.FocalLengthIn35mmFilm],
			[EXIF.GainControl],
			[EXIF.ISOSpeedRatings],
			[EXIF.LightSource],
			[EXIF.Make],
			[EXIF.MaxApertureValue],
			[EXIF.MeteringMode],
			[EXIF.Model],
			[EXIF.Orientation],
			[EXIF.PlanarConfiguration],
			[EXIF.Saturation],
			[EXIF.SceneCaptureType],
			[EXIF.SceneType],
			[EXIF.SensingMethod],
			[EXIF.Sharpness],
			[EXIF.ShutterSpeedValue],
			[EXIF.SubjectDistance],
			[EXIF.WhiteBalance]
		)
	) p