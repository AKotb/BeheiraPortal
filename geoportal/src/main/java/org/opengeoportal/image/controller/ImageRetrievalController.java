package org.opengeoportal.image.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.opengeoportal.download.RequestStatusManager;
import org.opengeoportal.image.ImageRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/getImage")
public class ImageRetrievalController {
	@Autowired
	private RequestStatusManager requestStatusManager;
	final Logger logger = LoggerFactory.getLogger(this.getClass());
	final static long TIMEOUT = 5000;//milliseconds
	final static long INTERVAL = 500;//milliseconds
	
	@RequestMapping(method=RequestMethod.GET)
	public void getDownload(@RequestParam("requestId") String requestId, HttpServletResponse response) throws IOException, InterruptedException  {
		
		ImageRequest imageRequest = requestStatusManager.getImageRequest(UUID.fromString(requestId));
		File downloadPackage = imageRequest.getDownloadFile();
		long counter = 0;
		while (!downloadPackage.exists()){
			Thread.sleep(INTERVAL);
			counter += INTERVAL;
			if (counter >= TIMEOUT){
				logger.error("Download timed out.  File could not be found.");
				throw new IOException("File does not exist.");
			}
		}
		if (counter > 0){
			logger.debug("Milliseconds slept: " + Long.toString(counter));
		}
		logger.debug(downloadPackage.getName());
		logger.debug(downloadPackage.getAbsolutePath());

		logger.info("Image request with id [" + requestId + "] completed.");


		response.setContentLength((int) downloadPackage.length());
		response.setContentType("image/png");
		response.addHeader("Content-Disposition", "attachment;filename=" + downloadPackage.getName());
		response.setHeader("X-Frame-Options", "SAMEORIGIN");
		FileUtils.copyFile(downloadPackage, response.getOutputStream());
	}
}
