package org.OpenGeoPortal.Download;

import java.util.List;
import java.util.UUID;

import org.OpenGeoPortal.Download.Types.LayerRequest;

public interface LayerDownloader {
	public void downloadLayers(UUID requestId, List<LayerRequest> list) throws Exception;
}
