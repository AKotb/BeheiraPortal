package org.OpenGeoPortal.Utilities;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import org.OpenGeoPortal.Layer.BoundingBox;
import org.OpenGeoPortal.Metadata.LayerInfoRetriever;
import org.OpenGeoPortal.Solr.SolrRecord;
import org.OpenGeoPortal.Utilities.Http.OgpHttpClient;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;


public class QuickWfsDownload implements QuickDownload {
	/*http://geoserver01.uit.tufts.edu:80/wfs?request=GetFeature&version=1.1.0&typeName=topp:states&BBOX=-75.102613,40.212597,-72.361859,41.512517,EPSG:4326
	*/
	final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	DirectoryRetriever directoryRetriever;
	@Autowired
	LayerInfoRetriever layerInfoRetriever;
	@Autowired
	@Qualifier("httpClient.pooling")
	OgpHttpClient ogpHttpClient;
	
	@Override
	public File downloadZipFile(String layerId, BoundingBox bounds) throws Exception{

		SolrRecord layerInfo = layerInfoRetriever.getAllLayerInfo(layerId);
		
		//requests too near the poles are problematic
		BoundingBox requestBounds = null;
		Double requestMinY = bounds.getMinY();
		if (requestMinY < -85.0){
			 requestMinY = -85.0;
		}
		Double requestMaxY = bounds.getMaxY();
		if (requestMaxY > 85.0){
			 requestMaxY = 85.0;
		}
		requestBounds = new BoundingBox(bounds.getMinX(), requestMinY, bounds.getMaxX(), requestMaxY);
		String workspace = layerInfo.getWorkspaceName();
		String layerName = layerInfo.getName();
		String requestString = "request=GetFeature&version=1.1.0&outputFormat=shape-zip";
		requestString += "&typeName=" + workspace + ":" + layerName;
		requestString += "&srsName=EPSG:4326";
		requestString += "&BBOX=" + requestBounds.toString() + ",EPSG:4326";
		HttpClient httpclient = ogpHttpClient.getHttpClient();
		File outputFile = null;
    
    	String wfsLocation = ParseJSONSolrLocationField.getWfsUrl(layerInfo.getLocation());
        HttpGet httpget = new HttpGet(wfsLocation + "?" + requestString);

        logger.info("executing request " + httpget.getURI());
        
		try {
			HttpResponse response = httpclient.execute(httpget);
			logger.info("Response code: " + Integer.toString(response.getStatusLine().getStatusCode()));
			if (response.getStatusLine().getStatusCode() != 200){
				throw new Exception("Attempt to download " + layerName + " failed.");
			}
			
			HttpEntity entity = response.getEntity();
			String contentType = entity.getContentType().getValue();
			logger.info("returned content type:" + contentType);
			if (contentType.toLowerCase().contains("xml")){
				String responseContent = EntityUtils.toString(entity);
				logger.error(responseContent);
				throw new Exception("Remote server reported an error");
			}
			File directory = directoryRetriever.getDirectory("download");
			outputFile = new File(directory, OgpFileUtils.filterName(layerName) + ".zip");
			InputStream inputStream = entity.getContent();
			InputStream bufferedIn = new BufferedInputStream(inputStream);
			FileUtils.copyInputStreamToFile(bufferedIn, outputFile);
			bufferedIn.close();
			
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return outputFile;
}

	public DirectoryRetriever getDirectoryRetriever() {
		return directoryRetriever;
	}

	public void setDirectoryRetriever(DirectoryRetriever directoryRetriever) {
		this.directoryRetriever = directoryRetriever;
	}

	public LayerInfoRetriever getLayerInfoRetriever() {
		return layerInfoRetriever;
	}

	public void setLayerInfoRetriever(LayerInfoRetriever layerInfoRetriever) {
		this.layerInfoRetriever = layerInfoRetriever;
	}
}
