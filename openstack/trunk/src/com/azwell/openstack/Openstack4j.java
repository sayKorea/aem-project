package com.azwell.openstack;
import java.util.List;

import org.openstack4j.api.OSClient;
import org.openstack4j.api.identity.IdentityService;
import org.openstack4j.api.identity.ServiceManagerService;
import org.openstack4j.model.compute.Action;
import org.openstack4j.model.compute.Flavor;
import org.openstack4j.model.compute.Server;
import org.openstack4j.model.compute.VNCConsole;
import org.openstack4j.model.compute.VNCConsole.Type;
import org.openstack4j.model.identity.Access;
import org.openstack4j.model.identity.Service;
import org.openstack4j.model.identity.Tenant;
import org.openstack4j.model.identity.User;
import org.openstack4j.model.image.Image;
import org.openstack4j.model.network.Network;
import org.openstack4j.model.network.Router;
import org.openstack4j.model.network.Subnet;
import org.openstack4j.openstack.OSFactory;

public class Openstack4j {
	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		OSClient os = OSFactory	.builder()
        						.endpoint("http://192.168.47.1:5000/v2.0")
        						.credentials("admin","openstack")
        						.tenantName("demo")
        						.authenticate();
//		OSClient os2 = OSFactory.builderV3()
//        						.endpoint("http://192.168.47.1:5000/v2.0")
//        						.credentials("admin","openstack")
//        						.domainName("openstack")
//        						.authenticate();
		Access access = os.getAccess();
		access.getUser();
		System.out.println(os.getAccess().getVersion());
		System.out.println(os.getAccess().getToken());
		// Find all Users
//		List<? extends User> users = os.identity().users().list();

		// List all Tenants
//		List<? extends Tenant> tenants = os.identity().tenants().list();

		ServiceManagerService sm = os.identity().services();
//		sm.listEndpoints();
		// List Services
//		sm.list();
		
		// Find all Compute Flavors
		List<? extends Flavor> flavors = os.compute().flavors().list();
		for(int i= 0; i<flavors.size(); i++){
			System.out.println("FLAVORS : "+ flavors.get(i));
		}
		
		// Find all running Servers
		List<? extends Server> servers = os.compute().servers().list();
		for(int i= 0; i<servers.size(); i++){
			System.out.println("SERVERS : "+ servers.get(i));
		}
		
		os.compute().servers().action("9bc89c96-6f4f-41c8-97e1-5f28606fd461",Action.START);
		System.out.println("SERVERS : STATUS --> "+servers.get(1).getStatus().name());
		// Suspend a Server
//		os.compute().servers().action("serverId", Action.SUSPEND);

		// List all Networks
		List<? extends Network> networks = os.networking().network().list();
		for(int i= 0; i<networks.size(); i++){
			System.out.println("NETWORKS : "+ networks.get(i));
		}
		// List all Subnets
		List<? extends Subnet> subnets = os.networking().subnet().list();
		for(int i= 0; i<subnets.size(); i++){
			System.out.println("SUBNETS : "+ subnets.get(i));
		}
		
		// List all Routers
		List<? extends Router> routers = os.networking().router().list();
		for(int i= 0; i<routers.size(); i++){
			System.out.println("ROUTERS : "+ routers.get(i));
		}
		// List all Images (Glance)
		List<? extends Image> images = os.images().list();
		for(int i= 0; i<images.size(); i++){
			System.out.println("IMAGES : "+ images.get(i));
		}
		// Download the Image Data
//		InputStream is = os.images().getAsStream("imageId");
		
		
		String consoleOutput = os.compute().servers().getConsoleOutput("9c2fc1fe-b2ad-411d-a218-d69e568de090", 50);
		System.out.println("CONSOLE : " + consoleOutput);
		
		VNCConsole console = os.compute().servers().getVNCConsole("9c2fc1fe-b2ad-411d-a218-d69e568de090", Type.NOVNC);
		System.out.println("VNCConsole : "+console.getURL());
		
	}
}