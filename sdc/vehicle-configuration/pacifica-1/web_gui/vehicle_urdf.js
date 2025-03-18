VehicleUrdf = function(options) {
  var that = this;
  options = options || {};
  var ros = options.ros;
  this.path = options.path || '/';
  this.tfClient = options.tfClient;
  this.tire_object = options.tire_object;
  this.tire_caliper = options.tire_caliper,
  this.rootObject = options.rootObject || new THREE.Object3D();
  this.tfPrefix = options.tfPrefix || '';

  that.urdf = new ITRI_Urdf({
    link : 'base_link_ground',
    pose : {
      position: {x: -0.62, y: -0.05, z: 0.0},
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    },
    filename : 'model/pacifica.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.rootObject.add(that.urdf);

  that.license_plate = new ITRI_Urdf({
    link : 'base_link_ground',
    pose : {
      position: {x: -3.16, y: -0.01, z: 0.98},
      orientation: new THREE.Quaternion().setFromEuler(
        new THREE.Euler(1.45, 0, -1.57, 'ZYX'))
    },
    filename : 'model/license_plate.dae',
    scale : {x: 0.8, y: 0.8, z: 0.8},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix
  });
  that.rootObject.add(that.license_plate);

  that.tire_front_left = new ITRI_Urdf({
    link : 'tire_front_left',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    },
    filename : 'model/tire.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_object.front.left = that.tire_front_left;
  that.rootObject.add(that.tire_front_left);

  that.tire_front_right = new ITRI_Urdf({
    link : 'tire_front_right',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    },
    filename : 'model/tire.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_object.front.right = that.tire_front_right;
  that.rootObject.add(that.tire_front_right);

  that.tire_rear_left = new ITRI_Urdf({
    link : 'tire_rear_left',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    },
    filename : 'model/tire.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_object.rear.left = that.tire_rear_left;
  that.rootObject.add(that.tire_rear_left);

  that.tire_rear_right = new ITRI_Urdf({
    link : 'tire_rear_right',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: {x: 0.0, y: 0.0, z: 0.0, w: 1.0}
    },
    filename : 'model/tire.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_object.rear.right = that.tire_rear_right;
  that.rootObject.add(that.tire_rear_right);

  that.tire_front_left_caliper = new ITRI_Urdf({
    link : 'tire_front_left',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: new THREE.Quaternion().setFromEuler(
        new THREE.Euler(0., 1.57, 0., 'ZYX'))
    },
    filename : 'model/tire_caliper.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_caliper.left = that.tire_front_left_caliper;
  that.rootObject.add(that.tire_front_left_caliper);

  that.tire_front_right_caliper = new ITRI_Urdf({
    link : 'tire_front_right',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: new THREE.Quaternion().setFromEuler(
        new THREE.Euler(0., -1.57, 0., 'ZYX'))
    },
    filename : 'model/tire_caliper.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.tire_caliper.right = that.tire_front_right_caliper;
  that.rootObject.add(that.tire_front_right_caliper);

  that.tire_rear_left_caliper = new ITRI_Urdf({
    link : 'tire_rear_left',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: new THREE.Quaternion().setFromEuler(
        new THREE.Euler(0., 1.57, 0., 'ZYX'))
    },
    filename : 'model/tire_caliper.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.rootObject.add(that.tire_rear_left_caliper);

  that.tire_rear_right_caliper = new ITRI_Urdf({
    link : 'tire_rear_right',
    pose : {
      position: {x: 0.0, y: 0.0, z: 0.0},
      orientation: new THREE.Quaternion().setFromEuler(
        new THREE.Euler(0., -1.57, 0., 'ZYX'))
    },
    filename : 'model/tire_caliper.dae',
    scale : {x: 1.0, y: 1.0, z: 1.0},
    path : that.path,
    tfClient : that.tfClient,
    tfPrefix : that.tfPrefix,
  });
  that.rootObject.add(that.tire_rear_right_caliper);
};
