package org.OpenGeoPortal.Download;

import java.util.List;
import java.util.UUID;

import org.OpenGeoPortal.Proxy.Controllers.ImageRequest;

public interface RequestStatusManager {

	void addDownloadRequest(UUID requestId, String sessionId,
			List<MethodLevelDownloadRequest> layerRequests);

	void removeRequestsBySessionId(String sessionId);

	DownloadRequest getDownloadRequest(UUID requestId);

	void addImageRequest(UUID requestId, String sessionId,
			ImageRequest imageRequest);

	ImageRequest getImageRequest(UUID fromString);

}
