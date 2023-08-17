# Visualizzation libs
import matplotlib.pyplot as plt # side-stepping mpl backend
from sklearn.decomposition import PCA # Principal Component Analysis module
# Data Processing libs
import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
from matplotlib.colors import ListedColormap # to map color

# Cross-validation scores
import sklearn.metrics as metrics
from sklearn.model_selection import StratifiedKFold

from sklearn.model_selection import learning_curve
from sklearn.model_selection import cross_val_predict
from sklearn.model_selection import validation_curve




def biplot_pca(transformed_features, pca, columns, lenght=3.0, scaling_factor = 4):
    """
    This funtion will project your *original* features
    onto your principal component feature-space, so that you can
    visualize how "important" each one was in the multi-dimensional scaling
    
    USAGE:
     > from src.utils import biplot_pca
     > biplot_pca( pc_df, pca2d.components_, df_X_clean_scaled.columns.values,3.4)
    """

    # Scale the principal components by the max value in
    # the transformed set belonging to that component
    # 
    # scaling_factor  for visualization reason
    loadings = pca.components_.T * np.sqrt(pca.explained_variance_) * scaling_factor
    xvector = loadings[:, 0]
    yvector = loadings[:, 1]
    
    plt.figure(figsize=(13,8))    
    plt.scatter(transformed_features['PC1'], transformed_features['PC2'], color='y', alpha=0.5)
    plt.xlabel('PC 1')
    plt.ylabel('PC 2')

    for i in range(len(columns)):
    # Use an arrow to project each original feature as a
    # labeled vector on your principal component axes
        if np.sqrt(xvector[i]**2 + yvector[i]**2) >lenght: # only vectors greater than lenght
            plt.arrow(0, 0, xvector[i], yvector[i], color='b', width=0.0005, head_width=0.02, alpha=0.75)
            plt.text(xvector[i]*1.2, yvector[i]*1.2, list(columns)[i], color='b', alpha=0.95)
    
    plt.show()
    

def draw_pca_scatterplot(X_set,y_set, xlim,ylim,algo_name,setname):
    
    plt.xlim(xlim[0],xlim[1])
    plt.ylim(ylim[0],ylim[1])

    for i, j in enumerate(np.unique(y_set)):
        plt.scatter(X_set[y_set == j, 0], X_set[y_set == j, 1],
                    c = 'red' if j==1 else "green", label ='malignant' if j==1 else "benign")

    plt.title('{} with PCA ({} Set)' .format(algo_name,setname))
    plt.xlabel('Component 1')
    plt.ylabel('Component 2')
    plt.legend()
    
# for visualization  (and teaching) purpose
def draw_boundary( algo, X_train,X_test, y_train, y_test, verbose=0):
    algo_name = type(algo).__name__
    # for visualization
    reduction = PCA(n_components=2)
    X_train_reduced = reduction.fit_transform(X_train)    
    X_test_reduced = reduction.transform(X_test)
    
    
    # Trains model
    classifier = algo
    classifier.fit(X_train_reduced, y_train)    
    y_pred_reduced = classifier.predict(X_test_reduced)

    # Training and Test sets  
    sets = {"Training":(X_train_reduced, y_train), # Trainig set boundary
            "Testing":(X_test_reduced, y_test)} # Test set boundary
    
    
    #meshgrid 
    X1, X2 = np.meshgrid(np.arange(start = X_test_reduced[:, 0].min() - 1, stop = X_test_reduced[:, 0].max() + 1, step = 0.1),
                             np.arange(start = X_test_reduced[:, 1].min() - 1, stop = X_test_reduced[:, 1].max() + 1, step = 0.1))
    xlim = X1.min(), X1.max()
    ylim = X2.min(), X2.max()
    
    # plot the dataset
    if verbose>1:     
        print('Plotting the dataset...')
        plt.figure(figsize = (14,6))
        draw_pca_scatterplot(np.concatenate((X_train_reduced,X_test_reduced)), np.concatenate((y_train,y_test)),xlim,ylim,algo_name, 'Dataset')
        plt.show()
    
    # plot train and test set
    if verbose>0:
        print('Plotting train and test set...')
        for setname, (X_set, y_set) in sets.items():
            plt.figure(figsize = (14,6))
            draw_pca_scatterplot(X_set, y_set,xlim,ylim,algo_name, setname)
            plt.show()
    
    
    # plot decision boundary
    print('Plotting decision boundary on train and test set...')
    for setname, (X_set, y_set) in sets.items():
        plt.figure(figsize = (14,6))
        plt.contourf(X1, X2, classifier.predict(np.array([X1.ravel(), X2.ravel()]).T).reshape(X1.shape),
             alpha = 0.6, cmap = ListedColormap(( 'green','red')))
        draw_pca_scatterplot(X_set, y_set,xlim,ylim,algo_name, setname)    
        plt.title('{} Boundary Line with PCA ({} Set)' .format(algo_name,setname))
        plt.show()
        
        if (verbose>1 and setname == 'Training'):
            plt.figure(figsize = (14,6))
            plt.contourf(X1, X2, classifier.predict(np.array([X1.ravel(), X2.ravel()]).T).reshape(X1.shape),
             alpha = 0.6, cmap = ListedColormap(( 'green','red')))
            plt.title('{} Boundary Line with PCA ({} Set)' .format(algo_name,setname))
            plt.show()
    

def cv_scores_explained(model, X, y):
    # Stratified 5 folds 
    cv = StratifiedKFold(n_splits=5)
    # Lists to store scores by folds (for macro measure only)
    recalls_train, recalls_test, f1_test, acc_test = list(), list(), list(), list()
    
    for train, test in cv.split(X, y):
        # fitting model on K-1 folds
        
        scaler = StandardScaler()
        # fitting and scaling a StandardScaler
        X_train = scaler.fit_transform(X[train, :])    #learn the parameters  and scaling  
        # scaling on test set
        X_test = scaler.transform(X[test, :]) # scaling using training parameters
        
        # training model
        model.fit(X_train, y[train])
        # prediciton on test set
        y_pred = model.predict(X_test)
        
        # getting testing accuracy, f1 and recall score (Positive and Negative class)
        acc = metrics.accuracy_score(y[test], y_pred)
        f1 = metrics.f1_score(y[test], y_pred)
        recall = metrics.recall_score(y[test], y_pred, average=None)
        
        # getting training recall score (Positive and Negative class)
        recall_training = metrics.recall_score(y[train], model.predict(X_train),average=None)
        
        # saving partial 'fold' results
        recalls_test.append(recall)
        acc_test.append(acc)
        f1_test.append(f1)
        recalls_train.append(recall_training)

        
    # we combine scores in folds by taking the mean to get a better measure of the global model performance. 
    print(f"== {type(model).__name__} CV Scores ==")
    f1_test_cv = np.mean(f1_test)
    acc_test_cv = np.mean(acc_test)
    recalls_train_cv = np.array(recalls_train).mean(axis=0)
    recalls_test_cv = np.array(recalls_test).mean(axis=0)    

    print("Train SPC:{0:.2f}; SEN:{1:.2f}".format(*tuple(recalls_train_cv)))
    print("Test SPC:{0:.2f}; SEN:{1:.2f}".format(*tuple(recalls_test_cv)))
    print(f"Test F1:{f1_test_cv:.2f}")
    print(f"Test ACC:{acc_test_cv:.2f}")
    
    return pd.DataFrame([[type(model).__name__, recalls_test_cv[0],recalls_test_cv[1],np.mean(f1_test),np.mean(acc_test) ]], columns=['Model','SPC','SEN','F1','ACC',])


#ROC curve (receiver operating characteristic curve) 
def roc_curve_model(model,x_test,y_test, algo_name=''):
    y_prob = model.predict_proba(x_test)[:,1] # This will give you positive class prediction probabilities
    false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
    roc_auc = auc(false_positive_rate, true_positive_rate)

    plt.figure(figsize=(5,5))
    plt.title('ROC '.format(algo_name))
    plt.plot(false_positive_rate,true_positive_rate, color='red',label = 'AUC '+algo_name+'= %0.2f' % roc_auc)
    plt.legend(loc = 'lower right')
    plt.plot([0, 1], [0, 1],linestyle='--')
    plt.axis('tight')
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    
    return plt


#validation curve
def validation_curve_model(X, Y, model, param_name, parameters, cv, ylim, scoring="recall", log=False, figsize = (8,5)):

    train_scores, test_scores = validation_curve(model, X, Y, param_name=param_name, param_range=parameters,cv=cv, scoring=scoring)
    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std = np.std(train_scores, axis=1)
    test_scores_mean = np.mean(test_scores, axis=1)
    test_scores_std = np.std(test_scores, axis=1)
   
    plt.figure(figsize = figsize)
    plt.title("Validation curve")
    plt.fill_between(parameters, train_scores_mean - train_scores_std,train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.fill_between(parameters, test_scores_mean - test_scores_std,test_scores_mean + test_scores_std, alpha=0.1, color="g")

    if log==True:
        plt.semilogx(parameters, train_scores_mean, 'o-', color="r",label="Training score")
        plt.semilogx(parameters, test_scores_mean, 'o-', color="g",label="Cross-validation score")
    else:
        plt.plot(parameters, train_scores_mean, 'o-', color="r",label="Training score")
        plt.plot(parameters, test_scores_mean, 'o-', color="g",label="Cross-validation score")

    if ylim is not None:
        plt.ylim(*ylim)
        
    plt.axvline(x=parameters[test_scores_mean.argmax()])
        
    plt.ylabel(f'{scoring} score')
    plt.xlabel('Parameter '+param_name)
    plt.legend(loc="best")
    
    return plt
  
    


# Learning curve
def learning_curve_model(X, Y, model, cv, train_sizes, ylim):

    plt.figure(figsize = (6,4))
    plt.title("Learning curve")
    plt.xlabel("Training examples")
    plt.ylabel("Score")


    train_sizes, train_scores, test_scores = learning_curve(model, X, Y, cv=cv, n_jobs=4, train_sizes=train_sizes)

    train_scores_mean = np.mean(train_scores, axis=1)
    train_scores_std  = np.std(train_scores, axis=1)
    test_scores_mean  = np.mean(test_scores, axis=1)
    test_scores_std   = np.std(test_scores, axis=1)
    
    plt.grid()
    
    plt.fill_between(train_sizes, train_scores_mean - train_scores_std,train_scores_mean + train_scores_std, alpha=0.1,
                     color="r")
    plt.fill_between(train_sizes, test_scores_mean - test_scores_std,test_scores_mean + test_scores_std, alpha=0.1, color="g")
    plt.plot(train_sizes, train_scores_mean, 'o-', color="r",label="Training score")
    plt.plot(train_sizes, test_scores_mean, 'o-', color="g",label="Cross-validation score")
    if ylim is not None:
        plt.ylim(*ylim)                  
    plt.legend(loc="best")
    return plt

from sklearn.metrics import roc_curve, auc


#roc curve_model
def roc_curve_model(model,x_test,y_test):
    y_prob = model.predict_proba(x_test)[:,1] # This will give you positive class prediction probabilitie
    false_positive_rate, true_positive_rate, thresholds = roc_curve(y_test, y_prob)
    roc_auc = auc(false_positive_rate, true_positive_rate)
    algo_name = type(model).__name__
    plt.figure(figsize=(5,5))
    plt.title(f'ROC {algo_name}')
    plt.plot(false_positive_rate,true_positive_rate, color='red',label = f'AUC {algo_name}={roc_auc:.2f}' )
    plt.legend(loc = 'lower right')
    plt.plot([0, 1], [0, 1],linestyle='--')
    plt.axis('tight')
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    plt.show()
    return plt




def kmeeans_silhouette_analysis(X, range_n_clusters):
    from sklearn.metrics import silhouette_samples, silhouette_score
    from sklearn.cluster import KMeans
    import matplotlib.cm as cm
    
    pca_2d = PCA(n_components=2)
    pca_2d_r = pca_2d.fit_transform(X)

    for n_clusters in range_n_clusters:
        # Create a subplot with 1 row and 2 columns
        fig, (ax1, ax2) = plt.subplots(1, 2)
        fig.set_size_inches(18, 5)

        # The 1st subplot is the silhouette plot
        # The silhouette coefficient can range from -1, 1 but in this example all
        # lie within [-0.1, 1]
        ax1.set_xlim([-0.1, 1])
        # The (n_clusters+1)*10 is for inserting blank space between silhouette
        # plots of individual clusters, to demarcate them clearly.
        ax1.set_ylim([0, len(X) + (n_clusters + 1) * 10])

        # Initialize the clusterer with n_clusters value and a random generator
        # seed of 10 for reproducibility.
        clusterer = KMeans(n_clusters=n_clusters, random_state=42) ###
        cluster_labels = clusterer.fit_predict(X)

        # The silhouette_score gives the average value for all the samples.
        # This gives a perspective into the density and separation of the formed
        # clusters
        silhouette_avg = silhouette_score(X, cluster_labels) ###
        print(f"For n_clusters ={n_clusters}  The average silhouette_score is : {silhouette_avg:.2f}")

        # Compute the silhouette scores for each sample
        sample_silhouette_values = silhouette_samples(X, cluster_labels) ##

        y_lower = 10
        for i in range(n_clusters):
            # Aggregate the silhouette scores for samples belonging to
            # cluster i, and sort them
            ith_cluster_silhouette_values = \
                sample_silhouette_values[cluster_labels == i] ##

            ith_cluster_silhouette_values.sort() ##

            size_cluster_i = ith_cluster_silhouette_values.shape[0]
            y_upper = y_lower + size_cluster_i
            cmap = plt.cm.get_cmap('Spectral')
            color = cmap(float(i) / n_clusters)
            ax1.fill_betweenx(np.arange(y_lower, y_upper),
                              0, ith_cluster_silhouette_values,
                              facecolor=color, edgecolor=color, alpha=0.7)

            # Label the silhouette plots with their cluster numbers at the middle
            ax1.text(-0.05, y_lower + 0.5 * size_cluster_i, str(i))

            # Compute the new y_lower for next plot
            y_lower = y_upper + 10  # 10 for the 0 samples

        ax1.set_title("The silhouette plot for the various clusters.")
        ax1.set_xlabel("The silhouette coefficient values")
        ax1.set_ylabel("Cluster label")

        # The vertical line for average silhouette score of all the values
        ax1.axvline(x=silhouette_avg, color="red", linestyle="--")

        ax1.set_yticks([])  # Clear the yaxis labels / ticks
        ax1.set_xticks([-0.1, 0, 0.2, 0.4, 0.6, 0.8, 1])

        # 2nd Plot showing the actual clusters formed
        colors = cmap(cluster_labels.astype(float) / n_clusters)
        ax2.scatter(pca_2d_r[:, 0], pca_2d_r[:, 1], marker='.', s=90, lw=0, alpha=0.7,
                    c=colors, edgecolor='k')

        # Labeling the clusters
        centers = clusterer.cluster_centers_
        # Draw white circles at cluster centers
        centers = pca_2d.transform(centers)
        ax2.scatter(centers[:, 0], centers[:, 1], marker='o',
                    c="white", alpha=1, s=250, edgecolor='k')

        for i, c in enumerate(centers):
            ax2.scatter(c[0], c[1], marker='$%d$' % i, alpha=1,
                        s=100, edgecolor='k')

        ax2.set_title("The visualization of the clustered data.")
        ax2.set_xlabel("PC1")
        ax2.set_ylabel("PC2")

        plt.suptitle((f"Silhouette analysis for KMeans clustering on sample data with n_clusters = {n_clusters}"  ),
                     fontsize=14, fontweight='bold')

        plt.show()
        
        
def plot_dendrograms(X):
    from scipy.cluster.hierarchy import dendrogram, linkage,median  # linkage analysis and dendrogram for visualization
    
    #ward = Similarity of two clusters is based on the increase in squared error when two clusters are merged
    methods = ['single','complete','average','median','ward']


    plt.figure(figsize=(25, 8))
    for i in range(len(methods)):
      plt.subplot(231+i)
      Z = linkage(X, method=methods[i]) #Perform hierarchical/agglomerative clustering. 
      de = dendrogram(
          Z,
          leaf_rotation=90.,
          leaf_font_size=11.,
          distance_sort='descending',
          truncate_mode = 'lastp',
          p=50

      )
      plt.title(methods[i])

    plt.tight_layout()
    



from sklearn.inspection import permutation_importance
#https://scikit-learn.org/stable/auto_examples/inspection/plot_permutation_importance.html#sphx-glr-auto-examples-inspection-plot-permutation-importance-py
def get_importance_features(model, X, y, columns):
    r = permutation_importance(model, X, y,
                               n_repeats=30,
                               random_state=0)

    for i in r.importances_mean.argsort()[::-1]:
        if r.importances_mean[i] - 2 * r.importances_std[i] > 0:
            print(f"{columns[i]}"
                  f" {r.importances_mean[i]:.3f}"
                  f" +/- {r.importances_std[i]:.3f}")

    fig, ax = plt.subplots()
    sorted_idx = r.importances_mean.argsort()
    ax.boxplot(r.importances[sorted_idx].T,
               vert=False, labels=columns[sorted_idx])
    ax.set_title("Permutation Importances (test set)")
    fig.tight_layout()
    plt.show() 

def plot_decision_tree(model, X,y, column_names,class_names=['Benign','Malignant'],file_name='plot_tree.pdf'):
    from sklearn import tree    

    #  Plot a decision tree nodes
    fig = plt.figure(figsize=(60,30))
    out = tree.plot_tree(model, 
                       feature_names=column_names,  
                       class_names=class_names,
                       filled=True, fontsize=25)
    #  Plot a decision tree edges
    for o in out: 
        arrow = o.arrow_patch
        if arrow is not None:
            arrow.set_edgecolor('red')
            arrow.set_linewidth(5)
    #file_name='plot_tree.pdf'
    print('Saving tree in file',file_name)
    plt.savefig(file_name)
    
# utility function
def draw_euclidean_distance(A,B,C,figsize=(15, 1), title='A,B,C weight and height (kg and cm)'):
    """ Computes the distance  between the (A,B) and (A,C) points and plot the result """
    
    # computes the distance  between the two points d = √(ΔEx^2 + ΔEy^2) = √((x1-x2)^2 + (y1-y2)^2)
    distance_A_B = np.sqrt( ((A[0]-B[0])**2)+((A[1]-B[1])**2) )
    distance_A_C = np.sqrt( ((A[0]-C[0])**2)+((A[1]-C[1])**2) )
    
    # plot result
    fig, ax = plt.subplots(figsize=figsize)
    ax.set(title=title, ylabel='weight', xlabel='height')
    # draw A, B, C
    ax.text(A[0],A[1],'A')
    ax.text(B[0],B[1],'B')
    ax.text(C[0],C[1],'C')

    # draw the distance A , B
    ax.plot((A[0],B[0]),(A[1],B[1]), color='green', linestyle='dashed', marker='o', markerfacecolor='blue',alpha=0.4)
    ax.text((A[0]+B[0])/2,(A[1]+B[1])/2,f'd(A,B): {distance_A_B:.1f}')

    # draw the distance A , C
    ax.plot((A[0],C[0]),(A[1],C[1]), color='red', linestyle='dashed', marker='o', markerfacecolor='blue',alpha=0.4)
    ax.text((A[0]+C[0])/2,(A[1]+C[1])/2,f'd(A,C): {distance_A_C:.1f}')

    plt.show()
